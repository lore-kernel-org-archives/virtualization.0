From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [RFC] virtio-mmio: Update the device to OASIS spec version
Date: Tue, 20 Jan 2015 17:51:11 +0000
Message-ID: <1421776271.14076.21.camel@arm.com>
References: <20150115165101.GA29808@redhat.com>
	<1421343158.4601.7.camel@arm.com> <20150115175132.GA30453@redhat.com>
	<1421345477.4601.9.camel@arm.com> <20150115182903.GA30947@redhat.com>
	<1421347322.4601.13.camel@arm.com> <20150115191203.GA31136@redhat.com>
	<1421689554.17436.30.camel@arm.com> <20150119183647.GB5336@redhat.com>
	<1421774303.14076.19.camel@arm.com> <20150120174425.GA2706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150120174425.GA2706@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2015-01-20 at 17:44 +0000, Michael S. Tsirkin wrote:
> Good. But your current code will also try to support a mix: device that
> uses the new transport underneath, but old layout and semantics on top.

It will not try to support the mix, but rather will not stop it from
working.

> This has no value: the spec does *not* define such devices
> and it also does not match any hosts, so this just adds to support matrix.
> And if linux supports it, someone *will* ship such a
> device and we'll be stuck with it forever.
>
> So please, detect out of spec devices and fail gracefully.
> pci and s390 do this already.

Ok, let it be. Will send v2 in a second.

Pawel
