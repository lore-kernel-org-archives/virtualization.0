From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 08:50:55 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E41F2D9@shsmsx102.ccr.corp.intel.com>
References: <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <539B606A-A0CA-4AA4-B99A-759C874A1EF8@vmware.com>
 <d69eafb4-ad0d-1617-9248-ea4fc776da58@redhat.com>
 <20200204033657-mutt-send-email-mst@kernel.org>
 <ce93331c-0099-dda7-e00f-126bf7826a40@redhat.com>
 <20200204114336-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E41F10F@shsmsx102.ccr.corp.intel.com>
 <20200205015911-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200205015911-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, February 5, 2020 3:05 PM, Michael S. Tsirkin wrote:
> 
> Well if we did the hint would be reliable, allowing host to immediately drop
> any pages it gets in the hint. 

"drop", you mean host to unmap the page from guest? I think that's not allowed for hints.

> Originally I wanted to speed up hinting by never
> waiting for host, but that does not seem to be what was
> implemented: the only place we don't wait is the shrinker

Didn't get this one. For FREE_PAGE_HINT, the hints are always sent to host without
an ack from host about whether it has read the hint or not. (please see get_free_page_and_send)

> and it seems a
> waste that we introduced complexity to host without getting any real
> benefit out of it.
> 
> VIRTIO_BALLOON_F_MUST_TELL_HOST doesn't really apply to hinting right
> now, 

There is no need I think, as host isn't allowed to use or unmap the hint page.

Best,
Wei
