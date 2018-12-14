From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
	vmap()
Date: Fri, 14 Dec 2018 10:31:28 -0500
Message-ID: <20181214102436-mutt-send-email-mst__13339.3872449689$1544801390$gmane$org@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
	<20181213102315-mutt-send-email-mst@kernel.org>
	<9459e227-a943-8553-732b-d7f5225a0f22@redhat.com>
	<20181214072334-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181214072334-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 14, 2018 at 07:33:20AM -0500, Michael S. Tsirkin wrote:
> > - unsafe_put_user/unsafe_get_user is not sufficient for accessing structures
> > (e.g accessing descriptor) or arrays (batching).
> 
> So you want unsafe_copy_xxx_user? I can do this. Hang on will post.

Like this basically? Warning: completely untested.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index b5e58cc0c5e7..d2afd70793ca 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -728,5 +728,10 @@ do {										\
 	if (unlikely(__gu_err)) goto err_label;					\
 } while (0)
 
+#define unsafe_copy_from_user(to, from, n)					\
+	 __copy_user_ll(to, (__force const void *)from, n)
+#define unsafe_copy_to_user(to, from, n)					\
+	 __copy_user_ll((__force void *)to, from, n)
+
 #endif /* _ASM_X86_UACCESS_H */
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..b9d515ba2920 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -271,6 +271,8 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 #define user_access_end() do { } while (0)
 #define unsafe_get_user(x, ptr, err) do { if (unlikely(__get_user(x, ptr))) goto err; } while (0)
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
+#define unsafe_copy_to_user(from, to, n) copy_to_user(from, to, n)
+#define unsafe_copy_from_user(from, to, n) copy_from_user(from, to, n)
 #endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
