From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 09:39:06 -0500
Message-ID: <49F5C38A.10806__38181.752296123$1240843422$gmane$org@codemonkey.ws>
References: <20090427123136.GA1152@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090427123136.GA1152@redhat.com>
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
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> Add optional MSI-X support: use a vector per virtqueue with
> fallback to a common vector and finally to regular interrupt.
> Teach all drivers to use it.
>
> I added 2 new virtio operations: request_vqs/free_vqs because MSI
> needs to know the total number of vectors upfront.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>   

Do you have userspace patches for testing?

Regards,

Anthony Liguori
