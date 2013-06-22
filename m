From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: what should a virtio-mmio transport without a backend look like?
Date: Sat, 22 Jun 2013 11:51:44 +0100
Message-ID: <CAFEAcA944MGNAJ7PFAbPo4uSrVEGnbyyscYyFQVC2raFH0N64A@mail.gmail.com>
References: <CAFEAcA9qCUQLZho8wJvewYJ0AEhDBc37_LpZWs8XBV1U7RVZgA@mail.gmail.com>
	<1371726501.3231.22.camel@hornet> <51C2FC5B.7080406@codeaurora.org>
	<CAFEAcA98py6MHQih8y0Vfr1T1PQj-Cy54cOzPbMfAOH3Xnf+Tw@mail.gmail.com>
	<51C4792F.6010709@codeaurora.org>
	<CAFEAcA9SM7K=-UFAkFOzRX0jcc5yJj6jAw4QFhWwC8VBO8SggA@mail.gmail.com>
	<1371833230.3155.19.camel@hornet>
	<CAFEAcA-iBduDCbwHYYe7BhAXoBx2A5EgZ6_251B3vMuODewxvQ@mail.gmail.com>
	<51C494EF.4060509@codeaurora.org>
	<CAFEAcA9VjH7DhKnFTK-CjnQPOV8vqduLjuQgWMrOzuz2V1VgwQ@mail.gmail.com>
	<51C49F52.1070906@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51C49F52.1070906@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Pawel Moll <pawel.moll@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 21 June 2013 19:45, Christopher Covington <cov@codeaurora.org> wrote:
> You were proposing to use a valid/existing MagicValue/Version/VendorID with a
> special DeviceID that does nothing. I'm saying why not use a valid/existing
> MagicValue/Version/VendorID/DeviceID with a special parameter setting, size=0,
> that does nothing?

Ah, I see. Well, it sounds from your quoted mount message as if they
do actually do something (ie the kernel finds a block device and
creates a /dev/vda for it), rather than nothing, which seems like
a bad thing. Also, it's mixing a detail of the backend layer (what
a zero-sized disk happens to look like) with the transport layer,
which seems a bit ugly spec-wise.

(Implementation wise I'm not crazy about it either since it would
be way more complicated than saying "no backend? OK, RAZ/WI".)

-- PMM
