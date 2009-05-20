From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Wed, 20 May 2009 20:40:32 +0300
Message-ID: <f43fc5580905201040j6ddea4fbq35f647accf7df79f__48608.893415849$1242844640$gmane$org@mail.gmail.com>
References: <20090520162130.GA22109@redhat.com>
	<f43fc5580905201021x265ffb8ax36b04a740c9fe92@mail.gmail.com>
	<4A143EB9.6080202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A143EB9.6080202@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 5/20/09, Avi Kivity <avi@redhat.com> wrote:
> Blue Swirl wrote:
>
> > Sparc64 also uses packets ("mondos", not implemented yet) for
> > interrupt vector data, there the packet size is 8 * 64 bits. I think
> > we should aim for a more generic API that covers this case also.
> >
> >
> >
>
>  Is the packet structure visible to software?

Yes, and the content of the packets is defined by software. If there
is framing outside the user data (I don't know), this is not visible.
