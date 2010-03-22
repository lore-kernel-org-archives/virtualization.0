From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/9] virtio-serial fixes, ABI updates
Date: Mon, 22 Mar 2010 10:25:21 +0530
Message-ID: <20100322045521.GB24577@amit-x200.redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<20100321134753.GA12758@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100321134753.GA12758@redhat.com>
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Sun) Mar 21 2010 [15:47:53], Michael S. Tsirkin wrote:
> On Fri, Mar 19, 2010 at 05:28:37PM +0530, Amit Shah wrote:
> > Hello,
> > 
> > This series fixes a few issues pointed out by Avi and Juan. Avi
> > pointed out we should do full scatter/gather processing of guest data
> > even if current (well-behaved) guests don't send multiple iovs per
> > element.
> > 
> > Juan pointed out a few migration-related bugs.
> > 
> > In handling the migration fixes, I noticed hot-plug/unplug isn't
> > handled perfectly for the migration case: ports are enumerated and the
> > port numbering has to be consistent with the guest's numbering. If
> > there's a mismatch, control messages meant for one port could be
> > interpreted for another.
> 
> BTW, I think virtio serial migration code needs to be fixed
> to be backwards compatible with old qemu if multiport
> feature is off.

This is already done; the savevm version number is bumped up.

> > To solve this issue, I go back to maintaining a bitmap in the config
> > space for active ports. Hot-plug and unplug can be added easily via
> > the config space as a result.
> 
> As I commented on the kernel driver, I'm not sure this is a good choice.

I've replied to that comment; please let me know if it's a concern.
Also, what do others think?

		Amit
