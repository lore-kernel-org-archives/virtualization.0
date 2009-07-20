From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 34/54] Staging: hv: remove STRUCT_PACKED and STRUCT_ALIGNED defines
Date: Tue, 21 Jul 2009 01:46:41 +0200
Message-ID: <200907210146.41399.arnd@arndb.de>
References: <20090717180850.873962925@mini.kroah.org> <20090717180921.448023599@mini.kroah.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754392AbZGTXqw@vger.kernel.org>
In-Reply-To: <20090717180921.448023599@mini.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 17 July 2009, Greg Kroah-Hartman wrote:
> @@ -43,7 +43,7 @@ typedef struct _RING_BUFFER {
>         // volatile u32 InterruptMask;
>         // Ring data starts here + RingDataStartOffset !!! DO NOT place any fields below this !!!
>      u8         Buffer[0];
> -} STRUCT_PACKED RING_BUFFER;
> +} __attribute__((packed)) RING_BUFFER;
>  

The data structure is actually packed already, the attribute does not make it better
and could be removed. We also have __packed as a shortcut for __attribute__((packed)).

	Arnd <><
