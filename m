From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 09/14] xen: events: Remove redundant check on unsigned
	variable
Date: Fri, 16 Nov 2012 08:53:21 -0800
Message-ID: <b0cd27cf-919f-46b0-afa1-4566f6ea0f61__42891.0846043893$1353085507$gmane$org@email.android.com>
References: <1353048646-10935-1-git-send-email-tushar.behera@linaro.org>
	<1353048646-10935-10-git-send-email-tushar.behera@linaro.org>
	<20121116160923.GP22320@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8122767858365398159=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121116160923.GP22320@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tushar Behera <tushar.behera@linaro.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

--===============8122767858365398159==
Content-Type: multipart/alternative; boundary="----I3LDVZ2VLUSA4GSWOKOQ023V3XCOJH"

------I3LDVZ2VLUSA4GSWOKOQ023V3XCOJH
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

To be honest I'd nack this kind of patch. The test is only redundant in t=
he most trivial sense that the compiler can easily optimise away. The poi=
nt of the test is to make sure that the range is OK even if the type subs=
equently becomes signed (to hold a -ve error, for example).

J

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

>On Fri, Nov 16, 2012 at 12:20:41PM +0530, Tushar Behera wrote:
>> No need to check whether unsigned variable is less than 0.
>>=20
>> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
>Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
>> CC: Jeremy Fitzhardinge <jeremy@goop.org>
>> CC: xen-devel@lists.xensource.com
>> CC: virtualization@lists.linux-foundation.org
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>> ---
>>  drivers/xen/events.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
>> index 4293c57..cadd7d1 100644
>> --- a/drivers/xen/events.c
>> +++ b/drivers/xen/events.c
>> @@ -216,7 +216,7 @@ static void xen_irq_info_pirq_init(unsigned irq,
>>   */
>>  static unsigned int evtchn_from_irq(unsigned irq)
>>  {
>> -	if (unlikely(WARN(irq < 0 || irq >=3D nr_irqs, "Invalid irq %d!\n",
>irq)))
>> +	if (unlikely(WARN(irq >=3D nr_irqs, "Invalid irq %d!\n", irq)))
>>  		return 0;
>> =20
>>  	return info_for_irq(irq)->evtchn;
>> --=20
>> 1.7.4.1

--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
------I3LDVZ2VLUSA4GSWOKOQ023V3XCOJH
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head/><body><html><head></head><body>To be honest I&#39;d nack thi=
s kind of patch. The test is only redundant in the most trivial sense tha=
t the compiler can easily optimise away. The point of the test is to make=
 sure that the range is OK even if the type subsequently becomes signed (=
to hold a -ve error, for example).<br>
<br>
J<br><br><div class=3D"gmail_quote">Konrad Rzeszutek Wilk &lt;konrad.wilk=
@oracle.com&gt; wrote:<blockquote class=3D"gmail_quote" style=3D"margin: =
0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-lef=
t: 1ex;">
<pre style=3D"white-space: pre-wrap; word-wrap:break-word; font-family: s=
ans-serif; margin-top: 0px">On Fri, Nov 16, 2012 at 12:20:41PM +0530, Tus=
har Behera wrote:<br /><blockquote class=3D"gmail_quote" style=3D"margin:=
 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;">N=
o need to check whether unsigned variable is less than 0.<br /><br />CC: =
Konrad Rzeszutek Wilk &lt;konrad.wilk@oracle.com&gt;</blockquote><br />Ac=
ked-by: Konrad Rzeszutek Wilk &lt;konrad.wilk@oracle.com&gt;<br /><br /><=
blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0.8ex; bord=
er-left: 1px solid #729fcf; padding-left: 1ex;">CC: Jeremy Fitzhardinge &=
lt;jeremy@goop.org&gt;<br />CC: xen-devel@lists.xensource.com<br />CC: vi=
rtualization@lists.linux-foundation.org<br />Signed-off-by: Tushar Behera=
 &lt;tushar.behera@linaro.org&gt;<br />---<br />drivers/xen/events.c |   =
 2 +-<br />1 files changed, 1 insertions(+), 1 deletions(-)<br /><br />di=
ff --git a/drivers/xen/events.c b/drivers/xen/event
 s.c<br
/>index 4293c57..cadd7d1 100644<br />--- a/drivers/xen/events.c<br />+++ =
b/drivers/xen/events.c<br />@@ -216,7 +216,7 @@ static void xen_irq_info_=
pirq_init(unsigned irq,<br />*/<br />static unsigned int evtchn_from_irq(=
unsigned irq)<br />{<br />- if (unlikely(WARN(irq &lt; 0 || irq &gt;=3D n=
r_irqs, "Invalid irq %d!\n", irq)))<br />+ if (unlikely(WARN(irq &gt;=3D =
nr_irqs, "Invalid irq %d!\n", irq)))<br />  return 0;<br /><br /> return =
info_for_irq(irq)-&gt;evtchn;<br />-- <br /><a href=3D"http://1.7.4.1">1.=
7.4.1</a></blockquote><br /></pre></blockquote></div><br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.</body=
></html></body></html>
------I3LDVZ2VLUSA4GSWOKOQ023V3XCOJH--


--===============8122767858365398159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8122767858365398159==--
