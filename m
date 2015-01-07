From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v6 18/20] virtio: support revision-specific features
Date: Wed, 7 Jan 2015 21:10:07 +0200
Message-ID: <20150107191006.GB8734@redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-19-git-send-email-cornelia.huck@de.ibm.com>
	<20141228083206.GA6802@redhat.com>
	<20150107172232.57cbeb31.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150107172232.57cbeb31.cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 07, 2015 at 05:22:32PM +0100, Cornelia Huck wrote:
> On Sun, 28 Dec 2014 10:32:06 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Dec 11, 2014 at 02:25:20PM +0100, Cornelia Huck wrote:
> > > Devices may support different sets of feature bits depending on which
> > > revision they're operating at. Let's give the transport a way to
> > > re-query the device about its features when the revision has been
> > > changed.
> > > 
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > So now we have both get_features and get_features_rev, and
> > it's never clear which revision does host_features refer to.
> > IMHO that's just too messy.
> > Let's add get_legacy_features and host_legacy_features instead?
> 
> I wanted to avoid touching anything that does not support version 1.
> And this interface might still work for later revisions, no?

We can add _modern_ then, or rename host_features to host_legacy_features
everywhere as preparation.

-- 
MST
