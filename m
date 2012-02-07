From: Jidong Xiao <jidong.xiao@gmail.com>
Subject: Re: Strange finding about kernel samepage merging
Date: Mon, 6 Feb 2012 23:13:55 -0500
Message-ID: <CAG4AFWZGr8SQF0rV+iys04HWmQ5WEGvXNcSZ9qJ7Jj9+FRbjCg__1765.16924188963$1328588049$gmane$org@mail.gmail.com>
References: <CAG4AFWaXVEHP+YikRSyt8ky9XsiBnwQ3O94Bgc7-b7nYL_2PZQ@mail.gmail.com>
	<CANAOKxs8j2T2b0tKssFX9NeC1wyMqjLMQmgmRwMs9qvokYcW2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANAOKxs8j2T2b0tKssFX9NeC1wyMqjLMQmgmRwMs9qvokYcW2w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 6, 2012 at 10:35 PM, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> My guess is you end up with 2 copies of each page on the guest: the copy in
> the guest's page cache, and the copy in the buffer you allocated. From the
> perspective of the host this all looks like anonymous memory, so ksm merges
> the pages.

Yes, the result definitely shows that there two copies. But I don't
understand why there would be two copies. So whenever you allocate
memory in a guest OS, you will always create two copies of the same
memory?

An interesting thing is, if I replace the posix_memalign() function
with the malloc() function (See the original program, the commented
line.) there would be only one copy, i.e., no merging happens,
however, since I need to have some page-aligned memory, that's why I
use posix_memalign().

Regards
Jidong
