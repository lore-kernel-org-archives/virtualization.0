From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3] virtio: balloon: cleanups and a fix
Date: Mon, 07 May 2012 13:23:21 +0930
Message-ID: <87fwbcfxzi.fsf@rustcorp.com.au>
References: <cover.1335467427.git.amit.shah@redhat.com>
	<20120426200746.GA29932@redhat.com>
	<20120426201554.GA5804@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120426201554.GA5804@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 27 Apr 2012 01:45:54 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> On (Thu) 26 Apr 2012 [23:07:47], Michael S. Tsirkin wrote:
> > On Fri, Apr 27, 2012 at 12:45:54AM +0530, Amit Shah wrote:
> > > Hello,
> > > 
> > > The main fix is to update the host with the current balloon value on
> > > module removal after deflating the balloon.  Without the fix, the host
> > > has the wrong idea of the ballooned memory in the guest.  This is
> > > patch 2.
> > > 
> > > Patches 1 and 3 are cleanups with no effective code change.
> > 
> > 
> > better to just do fixes for 3.4. can you reorder pls?
> 
> Well if you just pick patch 2, it'll work fine.  There's no context
> change there.

1 and 3 applied.

Thanks!
Rusty.
