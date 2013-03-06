From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 0/6] virtio_add_buf replacement.
Date: Wed, 6 Mar 2013 16:09:41 +0800
Message-ID: <20130306080940.GA4034@hj.localdomain>
References: <87k3plaz3d.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87k3plaz3d.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 06, 2013 at 04:15:02PM +1100, Rusty Russell wrote:
> OK, so I've spent a few days benchmarking.  Turns out 80% of
> virtio_add_buf cases are uni-directional (including the
> always-performance-sensitive networking code), and that gets no
> performance penalty (though tests with real networking would be
> appreciated!).
> 
> I'm not reposting all the "convert driver to virtio_add_outbuf()"
> patches: just the scsi one which I didn't have before.  I won't actually
> remove virtio_add_buf() until the *following* merge window, just to be
> sure.

Why not send out all the patches in this series? It would be much easier
for people to read in one thread.

> One annoying thing about benchmarking is that in some cases, speeding up
> one side can make the whole thing slower, due to more wakeups.
> Device-side polling techniques might be required in future to get more
> performance.
> 
> Cheers,
> Rusty.
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 
Asias
