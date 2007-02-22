From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: rough sketch of revised patching infrastructure
Date: Thu, 22 Feb 2007 14:54:23 -0800
Message-ID: <45DE1F1F.2020700@goop.org>
References: <45DCFB6E.2010806@goop.org>	
	<1172115803.13378.63.camel@localhost.localdomain>	
	<45DD6EF7.9060808@goop.org>	
	<1172141757.13378.76.camel@localhost.localdomain>
	<45DDDD50.80502@goop.org>
	<1172184705.19233.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1172184705.19233.35.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ian Campbell <Ian.Campbell@XenSource.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Ian Campbell wrote:
>> +       else if (type =3D=3D PARAVIRT_PATCH(iret) ||
>> +                type =3D=3D PARAVIRT_PATCH(irq_enable_sysexit))
>> +               ret =3D paravirt_patch_jmp(type, clobbers, site, len);
>> +       else
>> +               ret =3D paravirt_patch_jmp(type, clobbers, site, len);
>>     =

>
> Should be a paravirt_patch_call?

Yep.  I noticed that after I posted it.  Should work aside from that.

    J
