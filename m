From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/4] virtio: console: fixes, SIGIO
Date: Tue, 31 Aug 2010 17:06:48 +0530
Message-ID: <20100831102802.GD25022@amit-laptop.redhat.com>
References: <cover.1282798831.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1282798831.git.amit.shah@redhat.com>
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

On (Thu) Aug 26 2010 [10:34:04], Amit Shah wrote:
> Hi Rusty,
> 
> The main thing in these patches is the introduction of injecting SIGIO
> on host-side connect/disconnect events and when new data is available
> for ports.
> 
> The first two patches fix bugs that I haven't seen, but look like the
> right thing to do.
> 
> These have been tested extensively using the test-virtserial test
> suite.
> 
> Please apply,

Since you haven't picked this up already, I'll send a new series that
has more fixes and another call to SIGIO. I'll also split up the series
in two patchsets, one for hot-unplug related fixes and one for the
SIGIO.

		Amit
