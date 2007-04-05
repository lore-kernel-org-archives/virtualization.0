From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 05 Apr 2007 15:19:39 -0700
Message-ID: <461575FB.9080508@xensource.com>
References: <461447F2.9010807@zytor.com>	<20070405011640.GL19575@sequoia.sous-sol.org>	<46144FA6.1000802@zytor.com>
	<4614867C.4060506@vmware.com>	<461539DF.6010502@zytor.com>
	<46156591.8080802@vmware.com>	<46156783.9030501@zytor.com>
	<461569B7.7060008@vmware.com>	<46156CC2.7080600@zytor.com>
	<46156D95.4070001@vmware.com>	<46156EDC.8080403@goop.org>
	<46157146.1090406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46157146.1090406@zytor.com>
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
> Yes, pretty much.  There are enough evidence that you can't trust CPU =

> architecture to stay sane.  Inside Transmeta it was a constant battle, =

> and we were a small company.
>   =


Is there any indication that the msr or cpuid instructions will change
in this way?  rd/wrmsr is pretty explicitly documented as taking the msr
in %ecx, and the value in %edx:eax; do you think that will change?  And
likewise cpuid?

    J
