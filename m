From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 05 Apr 2007 14:43:47 -0700
Message-ID: <46156D93.4030008@goop.org>
References: <461447F2.9010807@zytor.com>	<20070405011640.GL19575@sequoia.sous-sol.org>	<46144FA6.1000802@zytor.com>
	<4614867C.4060506@vmware.com>	<461539DF.6010502@zytor.com>
	<46156591.8080802@vmware.com>	<46156783.9030501@zytor.com>
	<461569B7.7060008@vmware.com> <46156CC2.7080600@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46156CC2.7080600@zytor.com>
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
> I actually expect rdmsr/wrmsr to have a higher likelihood of weird =

> things.  I don't know how many hypervisors can trap and handle those.

Most, if only to ignore them. =


    J
