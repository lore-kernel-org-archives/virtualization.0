From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: question on virtio
Date: Wed, 05 May 2010 14:40:15 -0500
Message-ID: <4BE1C99F.6050205__44859.4564375982$1273090797$gmane$org@codemonkey.ws>
References: <20100505110947.GA27872@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505110947.GA27872@redhat.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/05/2010 06:09 AM, Michael S. Tsirkin wrote:
> Hi!
> I see this in virtio_ring.c:
>
>          /* Put entry in available array (but don't update avail->idx *
> 	   until they do sync). */
>
> Why is it done this way?
> It seems that updating the index straight away would be simpler, while
> this might allow the host to specilatively look up the buffer and handle
> it, without waiting for the kick.
>    

It should be okay as long as you don't update idx for partial vectors.

Regards,

Anthony Liguori
