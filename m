From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Sun, 6 Oct 2019 07:48:45 -0400
Message-ID: <20191006073919-mutt-send-email-mst@kernel.org>
References: <5D7EE856.2080602@intel.com>
	<09257686-90df-5c31-c35f-9d16fc77fee1@redhat.com>
	<CAJuQAmpQV26kb9vTyoW-Q7PsD0SOfX+otkiQZAks1L6k7rgdig@mail.gmail.com>
	<20191003142854-mutt-send-email-mst@kernel.org>
	<CAJuQAmrCiPsofYpDvm8=i32d9c9yCmKpJRBSRFkeubP_2=XKtw@mail.gmail.com>
	<0df87f00-5102-973b-3a7a-735e44f4ac3f@redhat.com>
	<20191004043446-mutt-send-email-mst@kernel.org>
	<30c6feba-7037-b52f-3ef4-4a5c50be0aff@redhat.com>
	<CAJuQAmpwQ4guGtHTTWC60EAYBuJ264d6CgWmWEHSnb8-CRtWBw@mail.gmail.com>
	<859eada9-d3e2-8f28-ebd6-a8cb562dbff5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <859eada9-d3e2-8f28-ebd6-a8cb562dbff5@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Tyler Sanderson <tysand@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 06, 2019 at 10:30:40AM +0200, David Hildenbrand wrote:
> Please note the "use outside of a testing or debugging environment is
> not recommended". Usually you want a "soft" version of this, e.g., via
> the OOM handler (so only drop parts of the cache, not all).

Right. We'll need something softer I guess. By how much, I don't know.

-- 
MST
