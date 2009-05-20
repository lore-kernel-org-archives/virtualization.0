From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Wed, 20 May 2009 20:32:41 +0300
Message-ID: <4A143EB9.6080202__26179.4056198143$1242840908$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<f43fc5580905201021x265ffb8ax36b04a740c9fe92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f43fc5580905201021x265ffb8ax36b04a740c9fe92@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Blue Swirl <blauwirbel@gmail.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Blue Swirl wrote:
> Sparc64 also uses packets ("mondos", not implemented yet) for
> interrupt vector data, there the packet size is 8 * 64 bits. I think
> we should aim for a more generic API that covers this case also.
>
>   

Is the packet structure visible to software?

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
