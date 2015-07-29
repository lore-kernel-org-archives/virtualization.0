From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mmio: add ACPI probing
Date: Wed, 29 Jul 2015 13:01:26 +0300
Message-ID: <20150729125213-mutt-send-email-mst@redhat.com>
References: <1438076642-12080-1-git-send-email-graeme.gregory@linaro.org>
	<20150728130604-mutt-send-email-mst@redhat.com>
	<CAFEAcA9H6_oEFKFFNhcGW-8Yy8ng9iNnPbweTvMC46fwLmwA0w@mail.gmail.com>
	<20150728132113-mutt-send-email-mst@redhat.com>
	<CAFEAcA9x5kcojVAm-n4ycXQTK3yePqqv9DKvtREfpe5newAZvg@mail.gmail.com>
	<CAGCh1+kRyGNOH9mxRuEBLN+Ap4eJGS0wCC3YroBDuGnh8FsNKw@mail.gmail.com>
	<CAFEAcA9dHQkSyz7_V6Mb-gr=bA9BUdg4sGCDG7mwK3yiau9=Gw@mail.gmail.com>
	<55B833FF.20107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55B833FF.20107@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shannon Zhao <shannon.zhao@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, G Gregory <graeme.gregory@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 29, 2015 at 10:01:35AM +0800, Shannon Zhao wrote:
> 
> 
> On 2015/7/29 5:10, Peter Maydell wrote:
> > On 28 July 2015 at 21:28, G Gregory <graeme.gregory@linaro.org> wrote:
> >> > On 28 July 2015 at 21:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>> >> Mmm. I'm not terribly happy about stuff being in QEMU before the
> >>> >> ACPI spec for it has been finalised. We should not be picking
> >>> >> stuff randomly on the fly...
> >>> >>
> >>> >> If we want to fix the ACPI IDs QEMU is using for 2.4 then we
> >>> >> really need to do that now (ie within the next day or two).
> >>> >>
> >> > It is upto the owner of the QEMU prefix to allocate numbers. This is
> >> > not an issue for ACPI spec at all.
> > I mean "the specification for how this device should be advertised
> > in an ACPI table". I don't care whether that's an official ACPI
> > consortium thing or something less official. The table is
> > constructed by QEMU and read by the kernel (and possibly
> > also by UEFI?), so everybody needs to agree on what the
> > string is...
> 
> I agree with Peter. Maybe we should record these IDs at some place.

Right. And it should apply even if you keep using LNRO.
Pls create docs/specs/acpi_ids.txt and list them there.

For simplicity, I'd just replace LNRO with QEMU.

> Since QEMU is owner of this device and we register QEMU in ASWG, the
> official ID can be assigned by QEMU and the ID could(or should) be
> "QEMUXXXX". But what's the exact ID for this virtio-mmio? That's what we
> need to agree on and record.

So far we only had PVPANIC with ACPI ID QEMU0001.

> P.S. I don't see "QEMU" in the list of approved Vendor IDs for ACPI.
> http://www.uefi.org/sites/default/files/resources/PNPID_List.pdf
> http://www.uefi.org/sites/default/files/resources/ACPIID_List.pdf

Should appear there any day now.

> -- 
> Shannon
