From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH] virtio: (Partially) enable suspend/resume support
Date: Tue, 23 Nov 2010 08:48:05 +0530
Message-ID: <20101123031805.GB13002@amit-x200.redhat.com>
References: <da50daa251eb982c43fa474de8d4f1303f1ad57f.1285762305.git.amit.shah@redhat.com>
	<20101003155359.GB20285@redhat.com>
	<20101005134531.GD8207@amit-laptop.redhat.com>
	<20101005152319.GA22056@redhat.com>
	<20101006115418.GI8207@amit-laptop.redhat.com>
	<20101105101536.GA15514@redhat.com>
	<20101122134537.GB6979@amit-x200.redhat.com>
	<20101122145454.GB30157@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101122145454.GB30157@redhat.com>
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
Cc: Matthew Garrett <mjg@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Nov 22 2010 [16:54:54], Michael S. Tsirkin wrote:
> On Mon, Nov 22, 2010 at 07:15:37PM +0530, Amit Shah wrote:
> > 
> > The Linux kernel's suspend/resume notifiers currently offer the
> > following notifications:
> > - Preparing to go to suspended state (tasks will be frozen now)
> > - Preparing to restore the image saved at hibernate-time
> > - Restore succeeded (called after user-space threads are thawed)
> > 
> > 
> > What the Windows driver does is destroy all the virtqueues before
> > suspend and re-init all of them on restore.  This works well, but in the
> > Linux case, we don't have a notifier that gets called after restore
> > succeeds and before user-space tasks are thawed,
> 
> Let's add one?

Yes, that's where we need to start from.

		Amit
