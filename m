From: Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] virtio-net: Update the mtu code to match virtio spec
Date: Tue, 25 Oct 2016 16:06:41 -0400
Message-ID: <f7ta8ds9ory.fsf__15643.3956850835$1477426026$gmane$org@redhat.com>
References: <1477413335-17296-1-git-send-email-aconole@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1477413335-17296-1-git-send-email-aconole@redhat.com> (Aaron
	Conole's message of "Tue, 25 Oct 2016 12:35:35 -0400")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Jarod Wilson <jarod@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> From: Aaron Conole <aconole@bytheb.org>
>
> The virtio committee recently ratified a change, VIRTIO-152, which
> defines the mtu field to be 'max' MTU, not simply desired MTU.
>
> This commit brings the virtio-net device in compliance with VIRTIO-152.
>
> Additionally, drop the max_mtu branch - it cannot be taken since the u16
> returned by virtio_cread16 will never exceed the initial value of
> max_mtu.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jarod Wilson <jarod@redhat.com>
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---

Sorry about the subject line, David.  This is targetted at net-next, and
it appears my from was mangled.  Would you like me to resubmit with
these details corrected?

-Aaron
