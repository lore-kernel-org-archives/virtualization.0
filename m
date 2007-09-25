From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [kvm-devel] [PATCH 2/3] virtio ring implementation
Date: Tue, 25 Sep 2007 19:15:47 +0200
Message-ID: <46F94243.2000602__46026.9044539475$1190740835$gmane$org@qumranet.com>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<46F7BF41.9060705@qumranet.com>
	<1190727156.27805.332.camel@localhost.localdomain>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0051415869918610353=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190727156.27805.332.camel@localhost.localdomain>
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
--===============0051415869918610353==
Content-Type: multipart/alternative;
	boundary="------------010505020808080208030405"

This is a multi-part message in MIME format.
--------------010505020808080208030405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rusty Russell wrote:
>
> On Mon, 2007-09-24 at 15:44 +0200, Dor Laor wrote:
> > Rusty Russell wrote:
> > > +irqreturn_t vring_interrupt(int irq, void *_vq)
> > > +{
> > > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > > +
> > > +       pr_debug("virtqueue interrupt for %p\n", vq);
> > > +
> > > +       if (unlikely(vq->broken))
> > > +               return IRQ_HANDLED;
> > > +
> > > +       if (more_used(vq)) {
> > > +               pr_debug("virtqueue callback for %p (%p)\n",
> > > +                        vq, vq->vq.callback);
> > > +               if (!vq->vq.callback)
> > > +                       return IRQ_NONE;
> > > +               if (!vq->vq.callback(&vq->vq))
> > > +                       vq->vring.avail->flags |=
> > > VRING_AVAIL_F_NO_INTERRUPT;
> > > +       } else
> > > +               pr_debug("virtqueue %p no more used\n", vq);
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > >
> > Seems like there is a problem with shared irq line, the interrupt
> > handler always returns IRQ_HANDLED (except for the trivial case
> > were the callback is null).
>
> To reply for a second time, this time with thought.  Sorry.
>
> Yes, this code is wrong.  It should be:
>
> irqreturn_t vring_interrupt(int irq, void *_vq)
> {
>         struct vring_virtqueue *vq = to_vvq(_vq);
>
>         if (!more_used(vq)) {
>                 pr_debug("virtqueue interrupt with no work for %p\n", vq);
>                 return IRQ_NONE;
>         }
>
>         if (unlikely(vq->broken))
>                 return IRQ_HANDLED;
>
>         pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>         if (vq->vq.callback && !vq->vq.callback(&vq->vq))
>                 vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
>
>         return IRQ_HANDLED;
> }
>
> Cheers,
> Rusty.
>
At the moment it's not good enough, there is a potential race were the 
guest optimistically turn off
the VRING_AVAIL_F_NO_INTERRUPT in the vring_restart and afterwards finds 
there are more_used so
it consume them in the poll function.
If in the middle, packets arrive the host will see the flag is off and 
send irq.
In that case the above irq handler will report IRQ_NONE.

It's also not trivial to cancel the optimistic approach in the restart 
function since then there might be another race
that will result in missing irq reaching the guest.
I'll try to think of something better than a hypercall for switching irq 
on/off.
Cheers mate,
Dor.

--------------010505020808080208030405
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Rusty Russell wrote:
<blockquote cite="mid:1190727156.27805.332.camel@localhost.localdomain"
 type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <meta name="Generator"
 content="MS Exchange Server version 6.5.7652.24">
  <title>Re: [kvm-devel] [PATCH 2/3] virtio ring implementation</title>
<!-- Converted from text/plain format -->
  <p><font size="2">On Mon, 2007-09-24 at 15:44 +0200, Dor Laor wrote:<br>
&gt; Rusty Russell wrote:<br>
&gt; &gt; +irqreturn_t vring_interrupt(int irq, void *_vq)<br>
&gt; &gt; +{<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vring_virtqueue *vq = to_vvq(_vq);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue interrupt for %p\n", vq);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(vq-&gt;broken))<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (more_used(vq)) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue callback for %p (%p)\n",<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vq, vq-&gt;vq.callback);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vq-&gt;vq.callback)<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_NONE;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vq-&gt;vq.callback(&amp;vq-&gt;vq))<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vq-&gt;vring.avail-&gt;flags |=<br>
&gt; &gt; VRING_AVAIL_F_NO_INTERRUPT;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue %p no more used\n", vq);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;<br>
&gt; Seems like there is a problem with shared irq line, the interrupt<br>
&gt; handler always returns IRQ_HANDLED (except for the trivial case<br>
&gt; were the callback is null).<br>
  <br>
To reply for a second time, this time with thought.&nbsp; Sorry.<br>
  <br>
Yes, this code is wrong.&nbsp; It should be:<br>
  <br>
irqreturn_t vring_interrupt(int irq, void *_vq)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vring_virtqueue *vq = to_vvq(_vq);<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!more_used(vq)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue interrupt with no work for %p\n",
vq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_NONE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(vq-&gt;broken))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug("virtqueue callback for %p (%p)\n", vq,
vq-&gt;vq.callback);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vq-&gt;vq.callback &amp;&amp;
!vq-&gt;vq.callback(&amp;vq-&gt;vq))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vq-&gt;vring.avail-&gt;flags |=
VRING_AVAIL_F_NO_INTERRUPT;<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;<br>
}<br>
  <br>
Cheers,<br>
Rusty.<br>
  <br>
  </font>
  </p>
</blockquote>
At the moment it's not good enough, there is a potential race were the
guest optimistically turn off<br>
the <font size="2">VRING_AVAIL_F_NO_INTERRUPT in the vring_restart and
afterwards finds there are more_used so<br>
it consume them in the poll function. <br>
If in the middle, packets arrive the host will see the flag is off and
send irq.<br>
In that case the above irq handler will report IRQ_NONE.<br>
<br>
It's also not trivial to cancel the optimistic approach in the restart
function since then there might be another race<br>
that will result in missing irq reaching the guest.<br>
I'll try to think of something better than a hypercall for switching
irq on/off.<br>
Cheers mate,<br>
Dor.<br>
</font>
</body>
</html>

--------------010505020808080208030405--

--===============0051415869918610353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============0051415869918610353==--
