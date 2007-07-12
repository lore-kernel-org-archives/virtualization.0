From: "Matias Zabaljauregui" <matias.zabaljauregui@cern.ch>
Subject: Re: lguest over qemu
Date: Thu, 12 Jul 2007 17:02:30 +0200
Message-ID: <21a166410707120802g705b64d4o424e1f74a876ba60@mail.gmail.com>
References: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
	<1184210340.6005.723.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2006688148895471210=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184210340.6005.723.camel@localhost.localdomain>
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
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

--===============2006688148895471210==
Content-Type: multipart/alternative;
	boundary="----=_Part_19634_20803509.1184252550012"

------=_Part_19634_20803509.1184252550012
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Rusty,

You were right, it was the kernel configuration.
Changing the subject, in the next month I will be studying the possibilities
of implementing the idea behind xenoprof, for lguest.
Do you think this can be useful ?
Any advice?

Thanks
Matias


2007/7/12, Rusty Russell <rusty@rustcorp.com.au>:
>
> On Wed, 2007-07-11 at 11:51 +0200, Matias Zabaljauregui wrote:
> > Hi,
> >
> > I'm setting my lguest playing environment with qemu, but didn't have a
> > good start... maybe because my modest laptop only has 512Mb of RAM.
> >
> > This is my qemu  command:
> >
> >                          qemu -s -no-kqemu -m 400 -hda linux26.img
> > -net nic,model=rtl8139 -net tap
> >
> >
> > ( linux26.img  includes  a  2.6.21.5 kernel with the lguest-2.6.21-307
> > patch  )
> >
> >
> > This is my lguest command (executed within the qemu VM):
> >
> >                           ./lguest 64m /boot/kernel-2.6.21.5
> > --block=initrd-1.1-i386.img root=/dev/lbga
> >
> > always get this message (I have insisted with different virtual ram
> > amounts):
> >
> >                     lguest: failed to get page 167304
>
> I did most of my development under qemu, so I don't think that's the
> issue.  Can you send me your .config?
>
> Thanks,
> Rusty.
>
>

------=_Part_19634_20803509.1184252550012
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Rusty, <br><br>You were right, it was the kernel configuration. <br>Changing the subject, in the next month I will be studying the possibilities of implementing the idea behind xenoprof, for lguest. <br>Do you think this can be useful ?&nbsp; 
<br>Any advice? <br><br>Thanks<br>Matias<br><br><br><div><span class="gmail_quote">2007/7/12, Rusty Russell &lt;<a href="mailto:rusty@rustcorp.com.au">rusty@rustcorp.com.au</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, 2007-07-11 at 11:51 +0200, Matias Zabaljauregui wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I&#39;m setting my lguest playing environment with qemu, but didn&#39;t have a<br>&gt; good start... maybe because my modest laptop only has 512Mb of RAM.
<br>&gt;<br>&gt; This is my qemu&nbsp;&nbsp;command:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qemu -s -no-kqemu -m 400 -hda linux26.img<br>&gt; -net nic,model=rtl8139 -net tap<br>&gt;<br>&gt;<br>&gt; ( linux26.img&nbsp;&nbsp;includes&nbsp;&nbsp;a&nbsp;&nbsp;<a href="http://2.6.21.5">
2.6.21.5</a> kernel with the lguest-2.6.21-307<br>&gt; patch&nbsp;&nbsp;)<br>&gt;<br>&gt;<br>&gt; This is my lguest command (executed within the qemu VM):<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./lguest 64m /boot/kernel-<a href="http://2.6.21.5">
2.6.21.5</a><br>&gt; --block=initrd-1.1-i386.img root=/dev/lbga<br>&gt;<br>&gt; always get this message (I have insisted with different virtual ram<br>&gt; amounts):<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lguest: failed to get page 167304
<br><br>I did most of my development under qemu, so I don&#39;t think that&#39;s the<br>issue.&nbsp;&nbsp;Can you send me your .config?<br><br>Thanks,<br>Rusty.<br><br></blockquote></div><br>

------=_Part_19634_20803509.1184252550012--

--===============2006688148895471210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============2006688148895471210==--
