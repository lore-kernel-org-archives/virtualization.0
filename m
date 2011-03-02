From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/2] Fix hot-unplug: device removal while port in use
Date: Wed, 2 Mar 2011 19:08:35 +0530
Message-ID: <20110302133835.GA3055@amit-x200.redhat.com>
References: <cover.1299054025.git.amit.shah@redhat.com>
	<87aahdn5k7.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87aahdn5k7.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 02 Mar 2011 [21:38:08], Rusty Russell wrote:
> On Wed,  2 Mar 2011 13:53:06 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > A crash was observed when a device gets removed while a port is in
> > use.  When the port gets removed, we tried to free vq buffers.  The vq
> > no longer exists at this stage, just ensure we don't access it.
> > 
> > The second patch fixes a warning where the pci region is already
> > freed.  I'm not sure what or how the region gets freed, any clues
> > there will be helpful.
> 
> Put a printk and WARN_ON() in the pci region freeing code, look through
> the backtraces?

Well what seems to be happening is kref_put() in port_fops_release()
calls remove_port(), which calls device_destroy().  Now this triggers
another fput() on the same file, causing port_fops_release() to be
called again, which leads to device_destroy() being called on the same
region.

Slightly more clueful, but still clueless as to why this happens.

		Amit
