From: Zachary Amsden <zach@vmware.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 05 Apr 2007 14:25:15 -0700
Message-ID: <4615693B.3060704@vmware.com>
References: <461447F2.9010807@zytor.com>	<20070405011640.GL19575@sequoia.sous-sol.org>
	<46144FA6.1000802@zytor.com> <4614867C.4060506@vmware.com>
	<461539DF.6010502@zytor.com> <46156591.8080802@vmware.com>
	<4615659F.8070406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4615659F.8070406@zytor.com>
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
> I guess what I was trying to say was that we'd use setgpr_wrapper in =

> the case where you have an entrypoint with native (non-C) semantics; =

> in the other case we'd use an alternative to setgpr_wrapper.  Either =

> way, it sounds like we're talking about implementing =

> paravirtualization *after* CPU selection, i.e. we use IPI to get the =

> thing running on the proper CPU before invoking the paravirtualization =

> function?

Yes, re-implementing the IPI support is rather unuseful.

Zach
