From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for simple
	communication
Date: Tue, 23 Jun 2009 15:59:39 +0100
Message-ID: <20090623145937.GB10690@redhat.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906231355.53557.paul@codesourcery.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906231355.53557.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2009 at 01:55:52PM +0100, Paul Brook wrote:
> > Here are two patches. One implements a virtio-serial device in qemu
> > and the other is the driver for a guest kernel.
> 
> So I'll ask again. Why is this separate from virtio-console?

In the guest I wouldn't want virtio-serial devices to be mixed up with
the virtio-console device. virtio-console has nice clear usecase of
being an interactive console, and as such the guest OS can & should 
automatically start a mingetty/agetty process on any virtio-console
device it finds.  If we use virtio-console for data channels to, then
guest config becomes much harder todo automatically.

By all means share underlying code/infrastructure where appropriate,
but they must ultimately appear as clearly separate devices IMHO

Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|
