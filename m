From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] finish processor.h integration
Date: Tue, 18 Dec 2007 21:54:45 +0100
Message-ID: <E1J4jSf-00024X-GN__34137.875485658$1198015989$gmane$org@faramir.fjphome.nl>
References: <1198008293639-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-To: <1198008293639-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: tglx@linutronix.de, ehabkost@redhat.com, ak@suse.de, gcosta@redhat.com, chrisw@sous-sol.org, roland@redhat.com, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> What's left in processor_32.h and processor_64.h cannot be cleanly
> integrated. However, it's just a couple of definitions. They are moved
> to processor.h around ifdefs, and the original files are deleted. Note
> that there's much less headers included in the final version.

Either I must be missing something or this patch was corrupted somehow.

I see:

+#ifdef CONFIG_X86_32
[...]
+#endif /* CONFIG_X86_64 */

While I'd have expected:

+#ifdef CONFIG_X86_32
[...]
+#endif /* CONFIG_X86_32 */
+
+#ifdef CONFIG_X86_64
[...]
+#endif /* CONFIG_X86_64 */

Cheers,
FJP
