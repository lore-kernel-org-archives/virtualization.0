From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Tue, 11 Feb 2020 23:18:56 +0900
Message-ID: <51306985-90ac-6e6b-d085-4e076698c48c@i-love.sakura.ne.jp>
References: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
 <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F73E42AD6D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E42AD6D@shsmsx102.ccr.corp.intel.com>
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
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "tysand@google.com" <tysand@google.com>, "namit@vmware.com" <namit@vmware.com>, "rientjes@google.com" <rientjes@google.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "mhocko@kernel.org" <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/02/10 16:27, Wang, Wei W wrote:
>> Well, my comment is rather: "Do not try to reserve guest's memory. In other
>> words, do not try to maintain balloons on the guest side. Since host would
>> be able to cache file data on the host's cache, guests would be able to
>> quickly fetch file data from host's cache via normal I/O requests." ;-)
> 
> Didn't this one. The discussion was about guest pagecache pages v.s. guest balloon pages.
> Why is host's pagecache here?

I'm expecting a mode: "Guests should try to minimize pagecache pages (and teach
host to treat reclaimed pages as if POSIX_FADV_DONTNEED) instead of managing
guest balloon pages". In other words, as if

  while :; sleep 5; echo 1 > /proc/sys/vm/drop_caches; done

is running in the guest's kernel. And as if

  echo 2 > /proc/sys/vm/drop_caches

is triggered in the guest's kernel when host requested guests to reclaim
memory. No long-life balloons. Guest balloons do not need to care about
NUMA. Just leave the management of pagecache pages to the host.
