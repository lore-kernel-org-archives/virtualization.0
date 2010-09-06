From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] virtio: console: Send SIGIO in case of port unplug
Date: Mon, 6 Sep 2010 18:51:14 +0930
Message-ID: <201009061851.21524.rusty@rustcorp.com.au>
References: <cover.1283433264.git.amit.shah@redhat.com>
	<04e7f90d7eed7f18c9f0cae4de96253d0a8dc532.1283433264.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <04e7f90d7eed7f18c9f0cae4de96253d0a8dc532.1283433264.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2 Sep 2010 10:47:54 pm Amit Shah wrote:
> If a port has registered for SIGIO signals, let the application
> know that the port is getting unplugged.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Thanks Amit, these patches were really well organized and nice to read.

Applied them all...
Rusty.
