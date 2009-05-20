From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Wed, 20 May 2009 20:21:01 +0300
Message-ID: <f43fc5580905201021x265ffb8ax36b04a740c9fe92__48442.4036033035$1242844463$gmane$org@mail.gmail.com>
References: <20090520162130.GA22109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090520162130.GA22109@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 5/20/09, Michael S. Tsirkin <mst@redhat.com> wrote:
> define api for allocating/setting up msi-x irqs, and for updating them
>  with msi-x vector information, supply implementation in ioapic. Please
>  comment on this API: I intend to port my msi-x patch to work on top of
>  it.
>
>  Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sparc64 also uses packets ("mondos", not implemented yet) for
interrupt vector data, there the packet size is 8 * 64 bits. I think
we should aim for a more generic API that covers this case also.

For example, irq.c could support opaque packet payload of
unspecified/predefined size. MSI packet structure should be defined in
ioapic.c.

The pci_msi_ops structure could be 'const', or do you expect it to
change during execution?
