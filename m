From: "Grant McWilliams" <grantmasterflash@gmail.com>
Subject: Re: Re: [Xen-devel] State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 11:48:22 -0700
Message-ID: <ed123fa30807311148q6460d2d8nb012f1b4edeb042f@mail.gmail.com>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
	<4891FFBA.1020702@goop.org>
	<7fac565a0807311119p55e534f1hc15005aea46671a2@mail.gmail.com>
	<48920455.40204@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2094129671=="
Return-path: <xen-users-bounces@lists.xensource.com>
In-Reply-To: <48920455.40204@goop.org>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-users@lists.xensource.com>
List-Help: <mailto:xen-users-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=subscribe>
Sender: xen-users-bounces@lists.xensource.com
Errors-To: xen-users-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Alexey Eremenko <al4321@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, "Daniel P. Berrange" <berrange@redhat.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

--===============2094129671==
Content-Type: multipart/alternative;
	boundary="----=_Part_105949_31076811.1217530102776"

------=_Part_105949_31076811.1217530102776
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Jul 31, 2008 at 11:28 AM, Jeremy Fitzhardinge <jeremy@goop.org>wrote:

> Alexey Eremenko wrote:
> > Jeremy: Mr. Grant speaking about the future where Linux (2.6.28?)
> > mainline kernel will support Xen Dom0, not kernel 2.6.27, which only
> > improves Xen DomU.
> >
> > And I agree with Grant, that if Linux mainline will have Dom0
> > included, that may cause problems for all kinds of drivers.
>
> The intention is that a single kernel will be equally functional in all
> modes of operation.  If the kernel has dom0 capabilities, then they will
> only come into play when actually running under Xen; when booting
> natively, they will have no effect on anything else.  Naturally, running
> under Xen is likely incompatible with any other in-kernel virtualization
> system, so we need to make sure that they don't get in the way.  That's
> easy to arrange for kvm, but I'm not sure about VirtualBox as it is
> out-of-tree (though full source is available, right?).
>
>    J
>

Vbox OSE has full source available. I was working on a contract for a
corporation and was in the stage
of deciding which virtualization platform to run and installed Vbox in a Xen
system (running Xen). The installer
loaded the vbox driver (As well as set it up to load automatically) and sent
the server into a continuous reboot. Unfortunately this was
in a Datacenter that I had no physical access to. The Vbox developers jumped
all over me when I suggested that it was a bug.
When running Xen the VMware interface will come up and the driver will load
but the VMs just don't start. It seems like
that would be a much better situation than causing the entire machine to
crash. Seems like a Vbox problem. It was run in Dom0.

Grant

------=_Part_105949_31076811.1217530102776
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><div class="gmail_quote">On Thu, Jul 31, 2008 at 11:28 AM, Jeremy Fitzhardinge <span dir="ltr">&lt;<a href="mailto:jeremy@goop.org">jeremy@goop.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Alexey Eremenko wrote:<br>
&gt; Jeremy: Mr. Grant speaking about the future where Linux (2.6.28?)<br>
&gt; mainline kernel will support Xen Dom0, not kernel 2.6.27, which only<br>
&gt; improves Xen DomU.<br>
&gt;<br>
&gt; And I agree with Grant, that if Linux mainline will have Dom0<br>
&gt; included, that may cause problems for all kinds of drivers.<br>
<br>
</div>The intention is that a single kernel will be equally functional in all<br>
modes of operation. &nbsp;If the kernel has dom0 capabilities, then they will<br>
only come into play when actually running under Xen; when booting<br>
natively, they will have no effect on anything else. &nbsp;Naturally, running<br>
under Xen is likely incompatible with any other in-kernel virtualization<br>
system, so we need to make sure that they don&#39;t get in the way. &nbsp;That&#39;s<br>
easy to arrange for kvm, but I&#39;m not sure about VirtualBox as it is<br>
out-of-tree (though full source is available, right?).<br>
<font color="#888888"><br>
 &nbsp; &nbsp;J<br>
</font></blockquote></div><br>Vbox OSE has full source available. I was working on a contract for a corporation and was in the stage<br>of deciding which virtualization platform to run and installed Vbox in a Xen system (running Xen). The installer<br>
loaded the vbox driver (As well as set it up to load automatically) and sent the server into a continuous reboot. Unfortunately this was<br>in a Datacenter that I had no physical access to. The Vbox developers jumped all over me when I suggested that it was a bug.<br>
When running Xen the VMware interface will come up and the driver will load but the VMs just don&#39;t start. It seems like <br>that would be a much better situation than causing the entire machine to crash. Seems like a Vbox problem. It was run in Dom0.<br>
<br>Grant<br>
</div>

------=_Part_105949_31076811.1217530102776--


--===============2094129671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-users mailing list
Xen-users@lists.xensource.com
http://lists.xensource.com/xen-users
--===============2094129671==--
