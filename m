From: "Grant McWilliams" <grantmasterflash@gmail.com>
Subject: Re: Re: [Xen-devel] State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 13:07:26 -0700
Message-ID: <ed123fa30807311307j1687590bg31746d19f58d892d@mail.gmail.com>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
	<4891FFBA.1020702@goop.org>
	<7fac565a0807311119p55e534f1hc15005aea46671a2@mail.gmail.com>
	<48920455.40204@goop.org>
	<ed123fa30807311148q6460d2d8nb012f1b4edeb042f@mail.gmail.com>
	<48920B4F.7010608@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1844717539=="
Return-path: <xen-users-bounces@lists.xensource.com>
In-Reply-To: <48920B4F.7010608@goop.org>
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

--===============1844717539==
Content-Type: multipart/alternative;
	boundary="----=_Part_107073_11950246.1217534846523"

------=_Part_107073_11950246.1217534846523
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Jul 31, 2008 at 11:58 AM, Jeremy Fitzhardinge <jeremy@goop.org>wrote:

> Grant McWilliams wrote:
> > Vbox OSE has full source available. I was working on a contract for a
> > corporation and was in the stage
> > of deciding which virtualization platform to run and installed Vbox in
> > a Xen system (running Xen). The installer
> > loaded the vbox driver (As well as set it up to load automatically)
> > and sent the server into a continuous reboot. Unfortunately this was
> > in a Datacenter that I had no physical access to. The Vbox developers
> > jumped all over me when I suggested that it was a bug.
> > When running Xen the VMware interface will come up and the driver will
> > load but the VMs just don't start. It seems like
> > that would be a much better situation than causing the entire machine
> > to crash. Seems like a Vbox problem. It was run in Dom0.
>
> Yes, that sounds like an inherently unstable configuration.  I don't
> know anything about how VBox operates internally, but whatever pagetable
> management scheme they're using will quite likely not work under Xen
> without a lot of care.  The best we can do in that case is try to make
> sure that VBox doesn't attempt to come up.
>
> If they don't rely on VT/SVM, then it may work from within a Xen hvm
> domain, but I don't know what benefit that would have.  What were you
> trying to achieve by running VBox in dom0?
>
>    J
>

I wasn't really trying to run VBox in the dom0. I'd been running the Xen
kernel so long that I'd forgotten which
kernel I was on. Like I said when you start VMware the guest OS just doesn't
run which gives you a second
to ponder why. VBox uses VT/SVM if you check a box in the config. It was not
checked when it
crashed the server.

Depending on the application I use VBox or Xen for virtualization projects.
VBox acts as an HVM most of the time
so it's great for those times I'm virtualizing a product that I have no
control over. Xen is best for environments
that I do have control over.

Grant McWilliams

------=_Part_107073_11950246.1217534846523
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">On Thu, Jul 31, 2008 at 11:58 AM, Jeremy Fitzhardinge <span dir="ltr">&lt;<a href="mailto:jeremy@goop.org">jeremy@goop.org</a>&gt;</span> wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Grant McWilliams wrote:<br>
&gt; Vbox OSE has full source available. I was working on a contract for a<br>
&gt; corporation and was in the stage<br>
&gt; of deciding which virtualization platform to run and installed Vbox in<br>
&gt; a Xen system (running Xen). The installer<br>
&gt; loaded the vbox driver (As well as set it up to load automatically)<br>
&gt; and sent the server into a continuous reboot. Unfortunately this was<br>
&gt; in a Datacenter that I had no physical access to. The Vbox developers<br>
&gt; jumped all over me when I suggested that it was a bug.<br>
&gt; When running Xen the VMware interface will come up and the driver will<br>
&gt; load but the VMs just don&#39;t start. It seems like<br>
&gt; that would be a much better situation than causing the entire machine<br>
&gt; to crash. Seems like a Vbox problem. It was run in Dom0.<br>
<br>
</div>Yes, that sounds like an inherently unstable configuration. &nbsp;I don&#39;t<br>
know anything about how VBox operates internally, but whatever pagetable<br>
management scheme they&#39;re using will quite likely not work under Xen<br>
without a lot of care. &nbsp;The best we can do in that case is try to make<br>
sure that VBox doesn&#39;t attempt to come up.<br>
<br>
If they don&#39;t rely on VT/SVM, then it may work from within a Xen hvm<br>
domain, but I don&#39;t know what benefit that would have. &nbsp;What were you<br>
trying to achieve by running VBox in dom0?<br>
<font color="#888888"><br>
 &nbsp; &nbsp;J<br>
</font></blockquote></div><br>I wasn&#39;t really trying to run VBox in the dom0. I&#39;d been running the Xen kernel so long that I&#39;d forgotten which<br>kernel I was on. Like I said when you start VMware the guest OS just doesn&#39;t run which gives you a second <br>
to ponder why. VBox uses VT/SVM if you check a box in the config. It was not checked when it<br>crashed the server.<br><br>Depending on the application I use VBox or Xen for virtualization projects. VBox acts as an HVM most of the time<br>
so it&#39;s great for those times I&#39;m virtualizing a product that I have no control over. Xen is best for environments <br>that I do have control over.<br><br>Grant McWilliams<br>
</div>

------=_Part_107073_11950246.1217534846523--


--===============1844717539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-users mailing list
Xen-users@lists.xensource.com
http://lists.xensource.com/xen-users
--===============1844717539==--
