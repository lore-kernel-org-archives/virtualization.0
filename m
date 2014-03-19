From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] virtio-blk: make the queue depth configurable
Date: Wed, 19 Mar 2014 10:31:33 -0700
Message-ID: <1395250293.8649.51.camel__35441.8793962852$1395271802$gmane$org@joe-AO722>
References: <1394818263-29947-1-git-send-email-tytso@mit.edu>
	<1394818720.3253.1.camel@joe-AO722> <20140314180258.GA29201@thunk.org>
	<87y509scl3.fsf@rustcorp.com.au> <1395032434.2556.10.camel@joe-AO722>
	<1395041214.2556.17.camel@joe-AO722> <87zjkmr8w1.fsf@rustcorp.com.au>
	<CAErSpo7rhDGX2DB1kRb4iZDLGNRGrm+sEwt6LuRsd19X5coG8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAErSpo7rhDGX2DB1kRb4iZDLGNRGrm+sEwt6LuRsd19X5coG8Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: fes@google.com, virtio-dev@lists.oasis-open.org, Theodore Ts'o <tytso@mit.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Couple more bikesheddy things:

Is there ever a reason to use a non __builtin_const_p(perms)?

Maybe that should be a BUILD_BUG_ON too
	BUILD_BUG_ON(!builtin_const_p_perms)

My brain of little size gets confused by the
	BUILD_BUG_ON_ZERO(foo) +
vs
	BUILD_BUG_ON(foo);
as it just seems like more text for the same content.

Is there any value on the "_ZERO(foo) +" I don't understand?
