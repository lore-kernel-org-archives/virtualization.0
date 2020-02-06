From: David Hildenbrand <david@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Thu, 6 Feb 2020 12:00:51 +0100
Message-ID: <04d8a2aa-c08f-f411-2fce-1dac5ba72a83@redhat.com>
References: <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <20200203120225-mutt-send-email-mst@kernel.org>
 <CAJuQAmqGA9mhzR5AQeMDtovJAh7y8khC3qUtLKx_e9RdL0wFJQ@mail.gmail.com>
 <74cc25a6-cefb-c580-8e59-5b76fb680bf4@redhat.com>
 <CAJuQAmpiVqnNt-vSkQh5Gg63QZ49_nuz4+VW2Jfwn51gWVdtfA@mail.gmail.com>
 <b809340d-7e86-caf6-bf12-db7bb8265045@redhat.com>
 <CAJuQAmqeKvc_k7pmDuC1b+w6yezzHoSxZJ8WW5sHVo1yMsRPfg@mail.gmail.com>
 <20200205015057-mutt-send-email-mst@kernel.org>
 <CAJuQAmrAbkd+VNRVzC+J5wPyoyuWCavfE07ANvkFwufyz58=Xg@mail.gmail.com>
 <b280e9902d1a40dab8ba65fc1498d897a4b193e4.camel@linux.intel.com>
 <CAJuQAmoQK5wZ09sZB6c7nzaYSrO6h6uYT6ULE3UpwGQ=bCo9uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmoQK5wZ09sZB6c7nzaYSrO6h6uYT6ULE3UpwGQ=bCo9uw@mail.gmail.com>
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
To: Tyler Sanderson <tysand@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, namit@vmware.com, David Rientjes <rientjes@google.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

>>>     It's not about dangers as such. It's just that when linux hits OOM
>>>     all kind of error paths are being hit, latent bugs start triggering,
>>>     latency goes up drastically.
>>     Doesn't this suggest that the shrinker is preferable to the OOM
>>     notifier in the case that we're actually OOMing (with DEFLATE_ON_OOM)?
> 
>     I think it all depends on the use case. For the use case you
>     describe going to the shrinker might be preferable as you are
>     wanting to exert just a light bit of pressure to start some page
>     cache reclaim. However if you are wanting to make the deflation a
>     last resort sort of thing then I would think the OOM would make more
>     sense.

Long story short: What you actually want is free page reporting combined
with

a) avoiding the guest page cache (emulated nvdimms, virtio-pmem). Not
always possible and has some issues in non-trusted environments (IOW,
cloud).

b) a way to tame the page cache (e.g., drop it completely similar to
drop_caches, or a way to drop a specific fraction, things not touch for
the last $SECONDS) etc.

There are some nice discussions in response to Alexander's v16.1 posting.

-- 
Thanks,

David / dhildenb
