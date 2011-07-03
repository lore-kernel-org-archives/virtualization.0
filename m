From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_balloon: Notify guest only after deflating the
	balloon
Date: Sun, 3 Jul 2011 19:36:54 +0300
Message-ID: <20110703163653.GA25750__1042.63351900062$1309711054$gmane$org@redhat.com>
References: <1309576016-22800-1-git-send-email-levinsasha928@gmail.com>
	<20110703082748.GD13183@redhat.com> <1309686419.2250.8.camel@sasha>
	<20110703103051.GA15537@redhat.com>
	<1309690349.2250.21.camel@sasha>
	<20110703121137.GA15826@redhat.com>
	<1309696356.2250.31.camel@sasha>
	<20110703134439.GA22493@redhat.com>
	<1309705961.2250.36.camel@sasha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1309705961.2250.36.camel@sasha>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, dave@linux.vnet.ibm.com, Pekka Enberg <penberg@kernel.org>, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jul 03, 2011 at 06:12:41PM +0300, Sasha Levin wrote:
> If we choose to
> leave it this way we can just go ahead and remove MUST_TELL_HOST.

It probably needs to stay so that the host can detect that
the guest does guarantee telling it first.
-- 
MST
