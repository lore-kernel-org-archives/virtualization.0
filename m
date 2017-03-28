From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/3] virtio-balloon: use actual number of stats for
	stats queue buffers
Date: Tue, 28 Mar 2017 22:33:55 +0200
Message-ID: <CAK8P3a1RWU2un3AKDJkiSUZfk0n9e8SEz48RSxEb+6X5MVFWYQ@mail.gmail.com>
References: <20170328164659.4311-1-lprosek@redhat.com>
	<20170328164659.4311-3-lprosek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170328164659.4311-3-lprosek@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ladi Prosek <lprosek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 28, 2017 at 6:46 PM, Ladi Prosek <lprosek@redhat.com> wrote:
> The virtio balloon driver contained a not-so-obvious invariant that
> update_balloon_stats has to update exactly VIRTIO_BALLOON_S_NR counters
> in order to send valid stats to the host. This commit fixes it by having
> update_balloon_stats return the actual number of counters, and its
> callers use it when pushing buffers to the stats virtqueue.
>
> Note that it is still out of spec to change the number of counters
> at run-time. "Driver MUST supply the same subset of statistics in all
> buffers submitted to the statsq."
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>

>
Acked-by: Arnd Bergmann <arnd@arndb.de>
