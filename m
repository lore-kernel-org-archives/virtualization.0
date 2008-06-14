From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio: Use bus_type probe and remove methods
Date: Sat, 14 Jun 2008 14:02:26 +1000
Message-ID: <200806141402.27175.rusty__31175.6679475822$1213416288$gmane$org@rustcorp.com.au>
References: <1213361201-10854-1-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1213361201-10854-1-git-send-email-markmc@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 13 June 2008 22:46:40 Mark McLoughlin wrote:
> Hook up to the probe() and remove() methods in bus_type
> rather than device_driver. The latter has been preferred
> since 2.6.16.
>
> Signed-off-by: Mark McLoughlin <markmc@redhat.com>

Thanks, applied.

Cheers,
Rusty.
