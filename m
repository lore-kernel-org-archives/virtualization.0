From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-devel] [PATCH 2/3] virtio ring implementation
Date: Mon, 24 Sep 2007 15:44:33 +0200
Message-ID: <46F7BF41.9060705__42259.2436465949$1190642059$gmane$org@qumranet.com>
References: <1190625194.27805.199.camel@localhost.localdomain><1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5839898630076483675=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190625307.27805.203.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============5839898630076483675==
Content-Type: multipart/alternative;
	boundary="------------060203060201060203030304"

This is a multi-part message in MIME format.
--------------060203060201060203030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rusty Russell wrote:
>
> These helper routines supply most of the virtqueue_ops for hypervisors
> which want to use a ring for virtio.  Unlike the previous lguest
> implementation:
>
> 1) The rings are variable sized (2^n-1 elements).
> 2) They have an unfortunate limit of 65535 bytes per sg element.
> 3) The page numbers are always 64 bit (PAE anyone?)
> 4) They no longer place used[] on a separate page, just a separate
>    cacheline.
> 5) We do a modulo on a variable.  We could be tricky if we cared.
> 6) Interrupts and notifies are suppressed using flags within the rings.
>
> Users need only implement the new_vq and free_vq hooks (KVM wants the
> guest to allocate the rings, lguest does it sanely).
>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
[snip]
>
> +irqreturn_t vring_interrupt(int irq, void *_vq)
> +{
> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +       pr_debug("virtqueue interrupt for %p\n", vq);
> +
> +       if (unlikely(vq->broken))
> +               return IRQ_HANDLED;
> +
> +       if (more_used(vq)) {
> +               pr_debug("virtqueue callback for %p (%p)\n",
> +                        vq, vq->vq.callback);
> +               if (!vq->vq.callback)
> +                       return IRQ_NONE;
> +               if (!vq->vq.callback(&vq->vq))
> +                       vq->vring.avail->flags |= 
> VRING_AVAIL_F_NO_INTERRUPT;
> +       } else
> +               pr_debug("virtqueue %p no more used\n", vq);
> +
> +       return IRQ_HANDLED;
> +}
> +
>
Seems like there is a problem with shared irq line, the interrupt 
handler always returns IRQ_HANDLED (except for the trivial case
were the callback is null).

It can be solved by having a host irq counter (in the shared ring) and a 
guest irq counter and return
mb(); return (host_counter!=guest_counter)? IRQ_HANDLED:IRQ_NONE;

Dor.

--------------060203060201060203030304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Rusty Russell wrote:
<blockquote cite="mid:1190625307.27805.203.camel@localhost.localdomain"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator"
 content="MS Exchange Server version 6.5.7652.24">
  <title>[kvm-devel] [PATCH 2/3] virtio ring implementation</title>
<!-- Converted from text/plain format -->
  <p><font size="2">These helper routines supply most of the
virtqueue_ops for hypervisors<br>
which want to use a ring for virtio.&nbsp; Unlike the previous lguest<br>
implementation:<br>
  <br>
1) The rings are variable sized (2^n-1 elements).<br>
2) They have an unfortunate limit of 65535 bytes per sg element.<br>
3) The page numbers are always 64 bit (PAE anyone?)<br>
4) They no longer place used[] on a separate page, just a separate<br>
&nbsp;&nbsp; cacheline.<br>
5) We do a modulo on a variable.&nbsp; We could be tricky if we cared.<br>
6) Interrupts and notifies are suppressed using flags within the rings.<br>
  <br>
Users need only implement the new_vq and free_vq hooks (KVM wants the<br>
guest to allocate the rings, lguest does it sanely).<br>
  <br>
Signed-off-by: Rusty Russell <a class="moz-txt-link-rfc2396E" href="mailto:rusty@rustcorp.com.au">&lt;rusty@rustcorp.com.au&gt;</a><br>
  <br>
  </font></p>
</blockquote>
[snip]<br>
<blockquote cite="mid:1190625307.27805.203.camel@localhost.localdomain"
 type="cite">
  <p><font size="2">+irqreturn_t vring_interrupt(int irq, void *_vq)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vring_virtqueue *vq = to_vvq(_vq);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue interrupt for %p\n", vq);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(vq-&gt;broken))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (more_used(vq)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue callback for %p (%p)\n",<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vq, vq-&gt;vq.callback);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vq-&gt;vq.callback)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_NONE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vq-&gt;vq.callback(&amp;vq-&gt;vq))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vq-&gt;vring.avail-&gt;flags |=
VRING_AVAIL_F_NO_INTERRUPT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue %p no more used\n", vq);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
+}<br>
+</font></p>
</blockquote>
<font size="2">Seems like there is a problem with shared irq line, the
interrupt handler always returns IRQ_HANDLED (except for the trivial
case<br>
were the callback is null).<br>
<br>
It can be solved by having a host irq counter (in the shared ring) and
a guest irq counter and return<br>
mb(); return (host_counter!=guest_counter)? IRQ_HANDLED:IRQ_NONE;<br>
<br>
Dor.<br>
</font>
</body>
</html>

--------------060203060201060203030304--

--===============5839898630076483675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5839898630076483675==--
