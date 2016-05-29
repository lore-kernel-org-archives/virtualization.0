From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: couple virtio header files refer to non-existent "__KERNEL__" test
Date: Sun, 29 May 2016 12:04:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1605291200110.18116@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


  just noticed that these header files contain comments referring to
"the #ifdef __KERNEL__ part":

include/uapi/linux/virtio_console.h: * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
include/uapi/linux/virtio_config.h:/* This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
include/linux/virtio_console.h: * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so

but none of those files contain any "#ifdef __KERNEL__" test, i'm
assuming since those were removed when the header files were
refactored to use UAPI(?)

  in any event, someone is welcome to remove those useless references
if they are so inclined.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
