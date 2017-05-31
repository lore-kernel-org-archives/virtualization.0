From: "bfields@fieldses.org" <bfields@fieldses.org>
Subject: Re: remove function pointer casts and constify function tables
Date: Wed, 31 May 2017 17:00:36 -0400
Message-ID: <20170531210036.GD23526__28518.4297049002$1497319627$gmane$org@fieldses.org>
References: <20170513072557.GA14602@lst.de>
	<1494691819.31377.1.camel@primarydata.com>
	<20170515152134.GC24547@fieldses.org>
	<20170515154450.GA18630@lst.de> <20170523081159.GA19216@lst.de>
	<20170523122334.GA4298@fieldses.org>
	<20170526150839.GA4593@fieldses.org>
	<20170526150956.GB4593@fieldses.org>
	<20170526193133.GA9874@fieldses.org>
	<20170530200109-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170530200109-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, virtualization@lists.linux-foundation.org, "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>, Trond Myklebust <trondmy@primarydata.com>, "jlayton@poochiereds.net" <jlayton@poochiereds.net>, hch <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 30, 2017 at 08:03:12PM +0300, Michael S. Tsirkin wrote:
> On Fri, May 26, 2017 at 03:31:33PM -0400, bfields@fieldses.org wrote:
> > Looks like the culprit is very likely d85b758f72b0 "virtio_net: fix
> > support for small rings".
> > 
> > After that patch, my NFS server VM stops responding to packets after a
> > few minutes of testing.  Before that patch, my server keeps working.
> > 
> > --b.
> 
> 
> So I think I know what caused this: looks like some hypervisors
> aren't prepared to deal with a situation where packet size
> becomes very small.
> 
> But which hypervisors exactly? I'd like to know in order to detect these
> and decide whether I blacklist bad ones or whitelist known-good ones.

I'm running this under KVM on a Fedora 25 host
(4.10.15-200.fc25.x86_64).  Let me know if any more details about the
setup would be useful.

--b.
