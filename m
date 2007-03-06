From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 05 Mar 2007 17:53:58 -0800
Message-ID: <45ECC9B6.1060209@goop.org>
References: <20070305120631.GA14105@elte.hu>		<1173101297.26165.39.camel@localhost.localdomain>	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45ECC91D.1020809@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Jeremy Fitzhardinge wrote:
>> I think Jan's approach is better if it works (since there's no
>> compromise), but this is better if you want to get something working in
>> the near term.
>>   =

>
> Is Jan dynamically relinking the vdso at runtime?  =

Yes.  His patch adds a runtime relocation for the vdso.
http://marc.theaimsgroup.com/?l=3Dxen-devel&m=3D117309332600075&w=3D2

    J
