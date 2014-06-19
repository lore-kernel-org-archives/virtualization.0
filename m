From: David Marchand <david.marchand@6wind.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Thu, 19 Jun 2014 10:25:30 +0200
Message-ID: <53A29E7A.9030106__8014.35996913842$1404408033$gmane$org@6wind.com>
References: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>	<5399CF09.8030803@6wind.com>
	<87ppidnqmy.fsf@blackfin.pond.sub.org>	<539AC3E0.9090404@6wind.com>
	<539ACDE6.7020709@redhat.com>	<539AFF7C.7090702@6wind.com>
	<539B064D.2050501@redhat.com>	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>	<53A00464.8090609@6wind.com>
	<53A00DEB.8030400@redhat.com>
	<20140618104849.GH14030@stefanha-thinkpad.redhat.com>
	<53A1A9D9.6010908@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A1A9D9.6010908@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Vincent JARDIN <vincent.jardin@6wind.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/18/2014 05:01 PM, Andreas F=E4rber wrote:
> late onto this thread: SUSE Security team has just recently
> done a thorough review of QEMU ivshmem code because a customer has
> requested this be supported in SLES12. Multiple security-related
> patches were submitted by Stefan Hajnoczi and Sebastian Krahmer, and I
> fear they are probably still not merged for lack of active
> maintainer... In such cases, after review, I expect them to be picked
> up by Peter as committer or via qemu-trivial.
>
> So -1, against dropping it.

Are these patches on patchwork ?

> Vincent, you will find an RFC for an ivshmem-test in the qemu-devel
> list archives or possibly on my qtest branch. The blocking issue that
> I haven't worked on yet is that we can't unconditionally run the qtest
> because it depends on KVM enabled at configure time (as opposed to
> runtime) to have the device available.
> http://patchwork.ozlabs.org/patch/336367/
>
> As others have stated before, the nahanni server seems unmaintained,
> thus not getting packaged by SUSE either and making testing the
> interrupt parts of ivshmem difficult - unless we sort out and fill
> with actual test code my proposed qtest.

Thanks for the RFC patch.

About ivshmem server, yes I will look at it.
I will see what I can propose or if importing nahanni implementation =

as-is is the best solution.

Anyway, first, documentation.


-- =

David Marchand
