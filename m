From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-net: Read MAC only after initializing MSI-X
Date: Tue, 23 Aug 2011 13:19:36 +0930
Message-ID: <87bovg4wj3.fsf__26715.9742223614$1314071671$gmane$org@rustcorp.com.au>
References: <1313225461-24458-1-git-send-email-levinsasha928@gmail.com>
	<20110819152335.GA19489@redhat.com>
	<87hb5a5m3x.fsf@rustcorp.com.au>
	<20110822083613.GA18556@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110822083613.GA18556@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 22 Aug 2011 11:36:13 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Yes. Or maybe 'WHEN' - since if MSI-X is disabled again, it moves back.
> Let's update the spec to make it clearer?

I left the language as is, but added a footnote at the end of the
sentence:

If MSI-X is enabled for the device, two additional fields immediately
follow this header:
[footnote: ie. once you enable MSI-X on the device, the other
           fields move. If you turn it off again, they move back!]

Thanks,
Rusty.
