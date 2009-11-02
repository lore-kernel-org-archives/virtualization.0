From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCHv4 1/6] qemu/virtio: move features to an inline function
Date: Mon, 02 Nov 2009 16:33:53 -0600
Message-ID: <4AEF5E51.80101__17200.6651563153$1257201274$gmane$org@codemonkey.ws>
References: <cover.1257200517.git.mst@redhat.com>
	<20091102222329.GB15153@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091102222329.GB15153@redhat.com>
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
> devices should have the final say over which virtio features they
> support. E.g. indirect entries may or may not make sense in the context
> of virtio-console. In particular, for vhost, we do not want to report to
> guest bits not supported by kernel backend.  Move the common bits from
> virtio-pci to an inline function and let each device call it.
>
> No functional changes.
>   

This is a layering violation.  There are transport specific features and 
device specific features.  The virtio-net device should have no 
knowledge or nack'ing ability for transport features.

If you need to change transport features, it suggests you're modeling 
things incorrectly and should be supplying an alternative transport 
implementation.

Regards,

Anthony Liguori
