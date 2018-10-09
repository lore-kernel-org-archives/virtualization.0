From: "Jorgen S. Hansen" <jhansen@vmware.com>
Subject: Re: [PATCH] VMCI: Resource wildcard match fixed
Date: Tue, 9 Oct 2018 08:27:41 +0000
Message-ID: <A99A1956-D875-4E55-A344-ED1F3B4FD1E5@vmware.com>
References: <20180921073105.5758-1-jhansen@vmware.com>
	<20181002223502.GA31116@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9118145148987013249=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181002223502.GA31116@kroah.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pv-drivers <pv-drivers@vmware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============9118145148987013249==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_A99A1956D8754E55A344ED1F3B4FD1E5vmwarecom_"

--_000_A99A1956D8754E55A344ED1F3B4FD1E5vmwarecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



On 3 Oct 2018, at 00:35, Greg KH <gregkh@linuxfoundation.org<mailto:gregkh@=
linuxfoundation.org>> wrote:

On Fri, Sep 21, 2018 at 12:31:05AM -0700, Jorgen Hansen wrote:
When adding a VMCI resource, the check for an existing entry
would ignore that the new entry could be a wildcard. This could
result in multiple resource entries that would match a given
handle. One disastrous outcome of this is that the
refcounting used to ensure that delayed callbacks for VMCI
datagrams have run before the datagram is destroyed can be
wrong, since the refcount could be increased on the duplicate
entry. This in turn leads to a use after free bug. This issue
was discovered by Hangbin Liu using KASAN and syzkaller.

Fixes: bc63dedb7d46 ("VMCI: resource object implementation")
Reported-by: Hangbin Liu <liuhangbin@gmail.com<mailto:liuhangbin@gmail.com>=
>
Reviewed-by: Adit Ranadive <aditr@vmware.com<mailto:aditr@vmware.com>>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com<mailto:vdasa@vmware.com>>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com<mailto:jhansen@vmware.com>=
>
---
drivers/misc/vmw_vmci/vmci_driver.c   | 2 +-
drivers/misc/vmw_vmci/vmci_resource.c | 3 ++-
2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vm=
ci_driver.c
index d7eaf1eb11e7..003bfba40758 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);

MODULE_AUTHOR("VMware, Inc.");
MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.5.0-k");
+MODULE_VERSION("1.1.6.0-k");
MODULE_LICENSE("GPL v2");

You do know MODULE_VERSION means nothing, right?  Please just remove it.

Sure. Do you want a new version of this patch with it removed ? (The reason=
 for asking is that I already got a couple of notifications about the patch=
 being added to char-misc and char-misc-next).

Thanks,
Jorgen

--_000_A99A1956D8754E55A344ED1F3B4FD1E5vmwarecom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <9153A12E64E41245BB107D6F608FC6DA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; line-break:=
 after-white-space;" class=3D"">
<br class=3D"">
<div><br class=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">On 3 Oct 2018, at 00:35, Greg KH &lt;<a href=3D"mailto:greg=
kh@linuxfoundation.org" class=3D"">gregkh@linuxfoundation.org</a>&gt; wrote=
:</div>
<br class=3D"Apple-interchange-newline">
<div class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helv=
etica; font-size: 12px; font-style: normal; font-variant-caps: normal; font=
-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0p=
x; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px; text-decoration: none; float: none; display: inline !=
important;" class=3D"">On
 Fri, Sep 21, 2018 at 12:31:05AM -0700, Jorgen Hansen wrote:</span><br styl=
e=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; fo=
nt-style: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; text-align: start; text-indent: 0px; text-transform: none; w=
hite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text=
-decoration: none;" class=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D"">
When adding a VMCI resource, the check for an existing entry<br class=3D"">
would ignore that the new entry could be a wildcard. This could<br class=3D=
"">
result in multiple resource entries that would match a given<br class=3D"">
handle. One disastrous outcome of this is that the<br class=3D"">
refcounting used to ensure that delayed callbacks for VMCI<br class=3D"">
datagrams have run before the datagram is destroyed can be<br class=3D"">
wrong, since the refcount could be increased on the duplicate<br class=3D""=
>
entry. This in turn leads to a use after free bug. This issue<br class=3D""=
>
was discovered by Hangbin Liu using KASAN and syzkaller.<br class=3D"">
<br class=3D"">
Fixes: bc63dedb7d46 (&quot;VMCI: resource object implementation&quot;)<br c=
lass=3D"">
Reported-by: Hangbin Liu &lt;<a href=3D"mailto:liuhangbin@gmail.com" class=
=3D"">liuhangbin@gmail.com</a>&gt;<br class=3D"">
Reviewed-by: Adit Ranadive &lt;<a href=3D"mailto:aditr@vmware.com" class=3D=
"">aditr@vmware.com</a>&gt;<br class=3D"">
Reviewed-by: Vishnu Dasa &lt;<a href=3D"mailto:vdasa@vmware.com" class=3D""=
>vdasa@vmware.com</a>&gt;<br class=3D"">
Signed-off-by: Jorgen Hansen &lt;<a href=3D"mailto:jhansen@vmware.com" clas=
s=3D"">jhansen@vmware.com</a>&gt;<br class=3D"">
---<br class=3D"">
drivers/misc/vmw_vmci/vmci_driver.c &nbsp;&nbsp;| 2 &#43;-<br class=3D"">
drivers/misc/vmw_vmci/vmci_resource.c | 3 &#43;&#43;-<br class=3D"">
2 files changed, 3 insertions(&#43;), 2 deletions(-)<br class=3D"">
<br class=3D"">
diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vm=
ci_driver.c<br class=3D"">
index d7eaf1eb11e7..003bfba40758 100644<br class=3D"">
--- a/drivers/misc/vmw_vmci/vmci_driver.c<br class=3D"">
&#43;&#43;&#43; b/drivers/misc/vmw_vmci/vmci_driver.c<br class=3D"">
@@ -113,5 &#43;113,5 @@ module_exit(vmci_drv_exit);<br class=3D"">
<br class=3D"">
MODULE_AUTHOR(&quot;VMware, Inc.&quot;);<br class=3D"">
MODULE_DESCRIPTION(&quot;VMware Virtual Machine Communication Interface.&qu=
ot;);<br class=3D"">
-MODULE_VERSION(&quot;1.1.5.0-k&quot;);<br class=3D"">
&#43;MODULE_VERSION(&quot;1.1.6.0-k&quot;);<br class=3D"">
MODULE_LICENSE(&quot;GPL v2&quot;);<br class=3D"">
</blockquote>
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">You
 do know MODULE_VERSION means nothing, right? &nbsp;Please just remove it.<=
/span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-=
size: 12px; font-style: normal; font-variant-caps: normal; font-weight: nor=
mal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wi=
dth: 0px; text-decoration: none;" class=3D"">
</div>
</blockquote>
</div>
<br class=3D"">
<div class=3D"">Sure. Do you want a new version of this patch with it remov=
ed ? (The reason for asking is that I already got a couple of notifications=
 about the patch being added to char-misc and char-misc-next).</div>
<div class=3D""><br class=3D"">
</div>
<div class=3D"">Thanks,</div>
<div class=3D"">Jorgen</div>
</body>
</html>

--_000_A99A1956D8754E55A344ED1F3B4FD1E5vmwarecom_--

--===============9118145148987013249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9118145148987013249==--
