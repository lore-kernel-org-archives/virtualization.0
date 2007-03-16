From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Thu, 15 Mar 2007 21:58:37 -0800
Message-ID: <45FA320D.4010102@vmware.com>
References: <45FA054F.6020107@vmware.com> <45FA0D13.6080601@goop.org>
	<45FA16FE.7010805@vmware.com> <45FA26DA.7020109@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45FA26DA.7020109@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>   =

>>>> +        } else if (strcmp(secstrings+sechdrs[i].sh_name,
>>>> ".dynamic") =3D=3D 0) {
>>>> +            Elf32_Dyn *dyn =3D (void *)hdr + sechdrs[i].sh_offset;
>>>> +            int tag;
>>>> +            while ((tag =3D (++dyn)->d_tag) !=3D DT_NULL)
>>>>       =

>>>>         =

>>> Um, no.
>>>   =

>>>       =

>> Walk based on size instead?
>>     =

>
> No, I was just complaining about the embedded assignment, before dinner,
> so I was overly terse.
>   =


My last embedded assignment was a robot microcontroller, and I dropped =

out of that class.  So I _need_ embedded assignments.

Zach
