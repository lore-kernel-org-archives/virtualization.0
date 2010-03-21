From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/9] virtio-serial fixes, ABI updates
Date: Sun, 21 Mar 2010 15:47:53 +0200
Message-ID: <20100321134753.GA12758@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 19, 2010 at 05:28:37PM +0530, Amit Shah wrote:
> Hello,
> 
> This series fixes a few issues pointed out by Avi and Juan. Avi
> pointed out we should do full scatter/gather processing of guest data
> even if current (well-behaved) guests don't send multiple iovs per
> element.
> 
> Juan pointed out a few migration-related bugs.
> 
> In handling the migration fixes, I noticed hot-plug/unplug isn't
> handled perfectly for the migration case: ports are enumerated and the
> port numbering has to be consistent with the guest's numbering. If
> there's a mismatch, control messages meant for one port could be
> interpreted for another.

BTW, I think virtio serial migration code needs to be fixed
to be backwards compatible with old qemu if multiport
feature is off.

> To solve this issue, I go back to maintaining a bitmap in the config
> space for active ports. Hot-plug and unplug can be added easily via
> the config space as a result.

As I commented on the kernel driver, I'm not sure this is a good choice.

> The kernel driver has to be changed as well so that the changes are in
> sync with the changes here.
> 
> I've tested these patches on my test suite that tests for correctness
> and also hot-plug/unplug cases and fixes presented here.
> 
> Amit Shah (9):
>   virtio-serial-bus: save/load: Ensure target has enough ports
>   virtio-serial-bus: save/load: Ensure nr_ports on src and dest are
>     same.
>   virtio-serial: save/load: Ensure we have hot-plugged ports
>     instantiated
>   virtio-serial: Handle scatter-gather buffers for control messages
>   virtio-serial: Handle scatter/gather input from the guest
>   virtio-serial: Remove redundant check for 0-sized write request
>   virtio-serial: Update copyright year to 2010
>   virtio-serial-bus: Use a bitmap in virtio config space for active
>     ports
>   virtio-serial-bus: Let the guest know of host connection changes
>     after migration
> 
>  hw/virtio-console.c    |    4 +-
>  hw/virtio-serial-bus.c |  205 ++++++++++++++++++++++++++++++++++++------------
>  hw/virtio-serial.h     |    8 +-
>  3 files changed, 161 insertions(+), 56 deletions(-)
