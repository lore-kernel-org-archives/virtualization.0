From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/3] Fix ERROR: Macros with complex values should be
	enclosed in parentheses
Date: Mon, 15 May 2017 02:25:31 +0200
Message-ID: <20170515002531.GG14058__47693.0007258945$1494947347$gmane$org@lunn.ch>
References: <20170514175130.18664-1-macfij7@wp.pl>
	<20170514175130.18664-2-macfij7@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170514175130.18664-2-macfij7@wp.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Maciek Fijalkowski <macfij7@wp.pl>
Cc: jasonwang@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 14, 2017 at 07:51:29PM +0200, Maciek Fijalkowski wrote:
> From: Maciej Fijalkowski <macfij7@wp.pl>

Hi Maciek

Please include some commit message, even if it is just the checkpatch
error you are fixing.

Please include the subsystem/driver you are patch in the subject line.
Also, your subject of Fix ERROR: makes it sound a lot worse than it
is. 

net: virtio: Fix checkpatch error Complex macros should use ()

Also, you should at least compile test your change. It is clearly
wrong, as shown by 0-day.

       Andrew
