From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v5 18/19] virtio: support
	revision-specific features
Date: Wed, 10 Dec 2014 18:37:19 +0100
Message-ID: <20141210183719.6aefbcac.cornelia.huck@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417525227-14051-19-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-19-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue,  2 Dec 2014 14:00:26 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> Devices may support different sets of feature bits depending on which
> revision they're operating at. Let's give the transport a way to
> re-query the device about its features when the revision has been
> changed.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c          |   12 ++++++++++--
>  hw/virtio/virtio-bus.c         |   14 ++++++++++++--
>  include/hw/virtio/virtio-bus.h |    3 +++
>  include/hw/virtio/virtio.h     |    3 +++
>  4 files changed, 28 insertions(+), 4 deletions(-)

There seems to be something wrong with this patch - I noticed when I
fixed prop_bit64. Needs debugging.
