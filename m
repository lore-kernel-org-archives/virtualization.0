From: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2 1/4] mm/balloon_compaction: list interfaces
Date: Fri, 19 Apr 2019 14:41:19 -0700
Message-ID: <5A5146D6-9BE3-4240-BEBB-FDA5BC536E96__31558.7880484358$1555710136$gmane$org@gmail.com>
References: <20190328010718.2248-1-namit@vmware.com>
	<20190328010718.2248-2-namit@vmware.com>
	<679D6F11-07D7-4227-9D02-41F9F8901E61@vmware.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <679D6F11-07D7-4227-9D02-41F9F8901E61@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Pv-drivers <Pv-drivers@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Julien Freche <jfreche@vmware.com>, Nadav Amit <namit@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

> On Apr 8, 2019, at 10:35 AM, Nadav Amit <namit@vmware.com> wrote:
> 
>> On Mar 27, 2019, at 6:07 PM, Nadav Amit <namit@vmware.com> wrote:
>> 
>> Introduce interfaces for ballooning enqueueing and dequeueing of a list
>> of pages. These interfaces reduce the overhead of storing and restoring
>> IRQs by batching the operations. In addition they do not panic if the
>> list of pages is empty.
>> 
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Michael, may I ping for your ack?

Ping again?
