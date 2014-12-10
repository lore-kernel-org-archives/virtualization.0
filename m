From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v5 05/19] virtio: support more feature
	bits
Date: Wed, 10 Dec 2014 18:35:58 +0100
Message-ID: <20141210183558.7f3af67b.cornelia.huck@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417525227-14051-6-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-6-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue,  2 Dec 2014 14:00:13 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:


> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 070006c..23d713b 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -51,6 +51,17 @@ extern PropertyInfo qdev_prop_arraylen;
>          .defval    = (bool)_defval,                              \
>          }
> 
> +#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {  \
> +        .name      = (_name),                                    \
> +        .info      = &(qdev_prop_bit),                           \
> +        .bitnr    = (_bit),                                      \
> +        .offset    = offsetof(_state, _field)                    \
> +            + type_check(uint64_t,typeof_field(_state, _field)), \
> +        .qtype     = QTYPE_QBOOL,                                \
> +        .defval    = (bool)_defval,                              \
> +        }
> +
> +
>  #define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
>          .name      = (_name),                                    \
>          .info      = &(qdev_prop_bool),                          \

This one is of course broken. I'll send an updated patch tomorrow.
