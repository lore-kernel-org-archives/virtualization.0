From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] fix a code style in drivers/char/virtio_console.c
Date: Tue, 18 May 2010 10:52:30 +0530
Message-ID: <20100518052230.GA1706__14387.4160050929$1274160183$gmane$org@amit-laptop.redhat.com>
References: <AANLkTilW8zZxCOrdiefZ4ZtixprI58LzDZ6Cz03z4lFk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilW8zZxCOrdiefZ4ZtixprI58LzDZ6Cz03z4lFk@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Liu <lingjiujianke@gmail.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) May 18 2010 [13:17:22], Steven Liu wrote:
> fix a code style in drivers/char/virtio_console.c
> 
> Signed-off-by: Liu Qi <lingjiujianke@gmail.com>

NACK.

This style is deliberate and follows Rusty's style: if we end up using
'err' uninitialised in some code path, it can get flagged by source
checkers.

		Amit
