From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Wed, 4 Mar 2020 13:37:44 -0800
Message-ID: <20200304133744.00000fdb@intel.com>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
        <20200228172537.377327-2-jean-philippe@linaro.org>
        <20200302161611.GD7829@8bytes.org>
        <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
        <20200303130155.GA13185@8bytes.org>
        <20200303084753-mutt-send-email-mst@kernel.org>
        <20200303155318.GA3954@8bytes.org>
        <20200303105523-mutt-send-email-mst@kernel.org>
        <20200304133707.GB4177@8bytes.org>
        <20200304153821.GE646000@myrica>
        <20200304174045.GC3315@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200304174045.GC3315@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, robin.murphy@arm.com, jacob.jun.pan@intel.com, "Kaneda, Erik" <erik.kaneda@intel.com>, "Rothman, Michael A" <michael.a.rothman@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 4 Mar 2020 18:40:46 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> On Wed, Mar 04, 2020 at 04:38:21PM +0100, Jean-Philippe Brucker wrote:
> > I agree with this. The problem is I don't know how to get a new
> > ACPI table or change an existing one. It needs to go through the
> > UEFI forum in order to be accepted, and I don't have any weight
> > there. I've been trying to get the tiny change into IORT for ages.
> > I haven't been given any convincing reason against it or offered
> > any alternative, it's just stalled. The topology description
> > introduced here wasn't my first choice either but unless someone
> > can help finding another way into ACPI, I don't have a better
> > idea.  
> 
> A quote from the ACPI Specification (Version 6.3, Section 5.2.6,
> Page 119):
> 
> 	Table signatures will be reserved by the ACPI promoters and
> 	posted independently of this specification in ACPI errata and
> 	clarification documents on the ACPI web site. Requests to
> 	reserve a 4-byte alphanumeric table signature should be sent
> to the email address info@acpi.info and should include the purpose
> 	of the table and reference URL to a document that describes
> the table format. Tables defined outside of the ACPI specification
> 	may define data value encodings in either little endian or big
> 	endian format. For the purpose of clarity, external table
> 	definition documents should include the endian-ness of their
> 	data value encodings.
> 
> So it sounds like you need to specifiy the table format and send a
> request to info@acpi.info to get a table signature for it.
> 
+ Mike and Erik who work closely on UEFI and ACPICA.

Copy paste Erik's initial response below on how to get a new table,
seems to confirm with the process you stated above.

"Fairly easy. You reserve a 4-letter symbol by sending a message
requesting to reserve the signature to Mike or the ASWG mailing list or
info@acpi.info

There is also another option. You can have ASWG own this new table so
that not one entity or company owns the new table."

> Regards,
> 
> 	Joerg
