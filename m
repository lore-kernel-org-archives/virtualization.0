From: "Grant McWilliams" <grantmasterflash@gmail.com>
Subject: Re: Re: [Xen-devel] State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 10:54:38 -0700
Message-ID: <ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1673431734=="
Return-path: <xen-users-bounces@lists.xensource.com>
In-Reply-To: <20080731090845.GH23888@redhat.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-users@lists.xensource.com>
List-Help: <mailto:xen-users-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=subscribe>
Sender: xen-users-bounces@lists.xensource.com
Errors-To: xen-users-bounces@lists.xensource.com
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

--===============1673431734==
Content-Type: multipart/alternative;
	boundary="----=_Part_104328_7099938.1217526878942"

------=_Part_104328_7099938.1217526878942
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
>
> > Fedora 9's kernel-xen package has been based on the mainline kernel from
> > the outset, but it is still packaged as a separate kernel.  kernel-xen
> > has been dropped from rawhide (what will become Fedora 10), and all Xen
> > support - both 32 and 64 bit - has been rolled into the main kernel
> > package.
>

Does this mean in the future all Fedora kernels will be Xen kernels? Is this
wise? If I try to run VirtualBox on a Xen kernel the machine will reboot. If
the Vbox module is loaded at runtime it will reboot forever. Yes, I know
it's a Vbox issue but what about KVM. Can we run KVM on a Xen kernel?

Or am I reading this completely wrong?

Grant

------=_Part_104328_7099938.1217526878942
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
&gt; Fedora 9&#39;s kernel-xen package has been based on the mainline kernel from<br>
&gt; the outset, but it is still packaged as a separate kernel. &nbsp;kernel-xen<br>
&gt; has been dropped from rawhide (what will become Fedora 10), and all Xen<br>
&gt; support - both 32 and 64 bit - has been rolled into the main kernel<br>
&gt; package.<br>
</blockquote></div><br>Does this mean in the future all Fedora kernels will be Xen kernels? Is this wise? If I try to run VirtualBox on a Xen kernel the machine will reboot. If the Vbox module is loaded at runtime it will reboot forever. Yes, I know it&#39;s a Vbox issue but what about KVM. Can we run KVM on a Xen kernel? <br>
<br>Or am I reading this completely wrong?<br><br>Grant<br>
</div>

------=_Part_104328_7099938.1217526878942--


--===============1673431734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-users mailing list
Xen-users@lists.xensource.com
http://lists.xensource.com/xen-users
--===============1673431734==--
