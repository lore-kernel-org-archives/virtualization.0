From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Tue, 26 Jun 2012 17:45:41 -0400
Message-ID: <4FEA2D85.60002@redhat.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<4FEA1E2E.4020806@redhat.com>
	<CAK+C7kWKtoYC=1fBQ45RTFfNc3p2PwZbLMOefMTtzOfsqe_k8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK+C7kWKtoYC=1fBQ45RTFfNc3p2PwZbLMOefMTtzOfsqe_k8w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frank Swiderski <fes@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Rafael Aquini <aquini@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ying Han <yinghan@google.com>, mikew@google.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/26/2012 05:31 PM, Frank Swiderski wrote:
> On Tue, Jun 26, 2012 at 1:40 PM, Rik van Riel<riel@redhat.com>  wrote:

>> The code looks good to me, my only worry is the
>> code duplication. We now have 5 balloon drivers,
>> for 4 hypervisors, all implementing everything
>> from scratch...
>
> Do you have any recommendations on this?  I could (I think reasonably
> so) modify the existing virtio_balloon.c and have it change behavior
> based on a feature bit or other configuration.  I'm not sure that
> really addresses the root of what you're pointing out--it's still
> adding a different implementation, but doing so as an extension of an
> existing one.

Ideally, I believe we would have two balloon
top parts in a guest (one classical balloon,
one on the LRU), and four bottom parts (kvm,
xen, vmware & s390).

That way the virt specific bits of a balloon
driver would be essentially a ->balloon_page
and ->release_page callback for pages, as well
as methods to communicate with the host.

All the management of pages, including stuff
like putting them on the LRU, or isolating
them for migration, would be done with the
same common code, regardless of what virt
software we are running on.

Of course, that is a substantial amount of
work and I feel it would be unreasonable to
block anyone's code on that kind of thing
(especially considering that your code is good),
but I do believe the explosion of balloon
code is a little worrying.
