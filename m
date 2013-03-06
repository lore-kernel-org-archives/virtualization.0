From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/6] virtio_add_buf replacement.
Date: Wed, 06 Mar 2013 16:15:02 +1100
Message-ID: <87k3plaz3d.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com, mst@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

OK, so I've spent a few days benchmarking.  Turns out 80% of
virtio_add_buf cases are uni-directional (including the
always-performance-sensitive networking code), and that gets no
performance penalty (though tests with real networking would be
appreciated!).

I'm not reposting all the "convert driver to virtio_add_outbuf()"
patches: just the scsi one which I didn't have before.  I won't actually
remove virtio_add_buf() until the *following* merge window, just to be
sure.

One annoying thing about benchmarking is that in some cases, speeding up
one side can make the whole thing slower, due to more wakeups.
Device-side polling techniques might be required in future to get more
performance.

Cheers,
Rusty.
