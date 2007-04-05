From: Zachary Amsden <zach@vmware.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 05 Apr 2007 14:27:19 -0700
Message-ID: <461569B7.7060008@vmware.com>
References: <461447F2.9010807@zytor.com>	<20070405011640.GL19575@sequoia.sous-sol.org>
	<46144FA6.1000802@zytor.com> <4614867C.4060506@vmware.com>
	<461539DF.6010502@zytor.com> <46156591.8080802@vmware.com>
	<46156783.9030501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46156783.9030501@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
>
> It seems to me that perhaps this is the way to do it:
>
> - Add cpuid_everything, rdmsr_everything and wrmsr_everything
>   entrypoints;

Yes, although I think we can omit rdmsr / wrmsr.

>
> - Provide compatibility wrappers that simply invoke the cpuid, rdmsr,
>   and wrmsr entrypoints with appropriate parameter marshalling;
>
> - On hardware, point them to the functions which invoke setgpr_wrapper.
>
> What do you think?

Well it is more work than the hack, but it is more maintainable and =

makes for less assembly code - we could do all the parameter juggling in =

C for the paravirt-ops case.

Zach
